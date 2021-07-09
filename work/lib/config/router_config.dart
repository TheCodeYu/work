import 'package:work/pages/home.dart';
import 'package:work/utils/log_utils.dart';
import 'package:flutter/material.dart';

/// description:路由配置信息路由拦截
///
/// user: yuzhou
/// date: 2021/6/12

class RouterConfig {
  /// 路由拦截器,可以做些权限控制，比如token检查
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    LogUtil.info('RouterConfig', 'onGenerateRoute:  ${settings.toString()}');
    Map<String, WidgetBuilder> paths = <String, WidgetBuilder>{
      HomePage.defaultRoute: (context) => HomePage(),
      //   LoginPage.defaultRoute: (context) =>
      //       LoginPage(arguments: settings.arguments),
      //   SettingPage.defaultRoute: (context) =>
      //       SettingPage(arguments: settings.arguments),
      //   StoragePage.defaultRoute: (context) => StoragePage(),
      // '/webView': (context) {
      //   // webView全屏容器
      //   Map? arg = settings.arguments as Map?;
      //   return WebviewScaffold(
      //     url: arg!['url'],
      //     appBar: AppBar(
      //       iconTheme: IconThemeData(color: Colors.white),
      //       //backgroundColor: BaseWidget.,
      //       brightness: Brightness.dark,
      //       textTheme: TextTheme(
      //         headline6: TextStyle(
      //           color: Colors.white,
      //           fontSize: 18,
      //         ),
      //       ),
      //       title: Text(arg['title']),
      //     ),
      //   );
      // },
    };
    var builder = paths[settings.name];
    if (builder != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: builder,
      );
    }

    return null;
  }
}
