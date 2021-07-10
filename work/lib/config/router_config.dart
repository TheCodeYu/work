import 'package:work/components/deferred_widget.dart';
import 'package:work/pages/home.dart' deferred as rally;
import 'package:work/pages/home.dart';
import 'package:work/pages/splash/splash.dart';
import 'package:work/utils/adaptive.dart';
import 'package:work/utils/log_utils.dart';
import 'package:flutter/material.dart';

/// description:路由配置信息路由拦截
///
/// user: yuzhou
/// date: 2021/6/12

typedef PathWidgetBuilder = Widget Function(BuildContext, String);

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument a RegEx match if that is included
  /// in the pattern.
  ///
  /// ```dart
  /// Path(
  ///   'r'^/demo/([\w-]+)$',
  ///   (context, matches) => Page(argument: match),
  /// )
  /// ```
  final PathWidgetBuilder builder;
}

class RouterConfig {

  static List<Path> paths = [
    Path(
      r'^' + HomePage.defaultRoute,
          (context, match) =>DeferredWidget(rally.loadLibrary,()=>rally. HomePage()),
    ),
    Path(
      r'^/',
          (context, match) => const Splash(),
    ),
  ];

  /// 路由拦截器,可以做些权限控制，比如token检查
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    LogUtil.info('RouterConfig', 'onGenerateRoute:  ${settings.toString()}');
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if(settings.name==null) continue;

      if (regExpPattern.hasMatch(settings.name!)) {
        final firstMatch = regExpPattern.firstMatch(settings.name!);
        final match = (firstMatch!.groupCount == 0) ? firstMatch.group(0) : null;
        if (kIsWeb) {
          LogUtil.info('RouterConfig', 'onGenerateRoute:  ${settings.name}');
          return NoAnimationMaterialPageRoute<void>(
            builder: (context) => path.builder(context, match!),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match!),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
  }


class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}

