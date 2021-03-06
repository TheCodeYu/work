import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import "package:universal_html/html.dart" as html;
import 'package:url_strategy/url_strategy.dart';
import 'package:work/blocs/bloc_wrapper.dart';
import 'package:work/blocs/global/global_bloc.dart';
import 'package:work/config/i10n.dart';
import 'package:work/config/router_config.dart';

import 'constants/my_theme.dart';

main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  final div = html.BodyElement();
  div.append(html.Element.tag("img")
    ..classes.add("greeting")
    ..setAttribute('src', 'value'));
  print(div.outerHtml);
  print(div.querySelector('body > .greeting')!.getAttribute('src'));
  runApp(BlocWrapper(MyApp()));
}

class MyApp extends StatelessWidget {
  final sharedZAxisTransitionBuilder = const SharedAxisPageTransitionsBuilder(
    fillColor: Colors.blue,
    transitionType: SharedAxisTransitionType.scaled,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (ctx, state) {
      return MaterialApp(
        // shortcuts: <LogicalKeySet, Intent>{
        //   ...WidgetsApp.defaultShortcuts,
        //   LogicalKeySet(
        //       LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
        //   const SearchIntent(),
        // },
        // actions: <Type, Action<Intent>>{
        //   ...WidgetsApp.defaultActions,
        //   SearchIntent: ActionUnit.searchAction,
        // },
        scrollBehavior:
            const MaterialScrollBehavior().copyWith(scrollbars: false),
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.app,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: state.themeMode,
        theme: MyThemeData.lightThemeData(state).copyWith(
          platform: state.platform,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              for (var type in TargetPlatform.values)
                type: sharedZAxisTransitionBuilder,
            },
          ),
        ),
        darkTheme: MyThemeData.darkThemeData(state).copyWith(
          platform: state.platform,
        ),
        localizationsDelegates: [
          LocaleNamesLocalizationsDelegate(),
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: state.locale,
        localeResolutionCallback:

            /// [supportedLocales] : supportedLocales
            ///iOS???????????????????????? [en_US, zh_CN]  zh_Hans_CN languageCode-scriptCode-countryCode
            (Locale? _locale, Iterable<Locale>? supportedLocales) {
          ///?????????????????????????????????????????? zh_cn ?????????Zh_CN
          // if (_locale != null) {
          //   return _locale;
          // }
          Locale locale =
              Locale.fromSubtags(languageCode: 'zh'); //???APP??????????????????????????????????????????????????????
          /// [todo]???????????????????????????????????????????????????,??????????????????????????????????????????????????????,ios????????????????????????
          supportedLocales?.forEach((l) {
            if ((l.countryCode == _locale?.countryCode) &&
                (l.languageCode == _locale?.languageCode)) {
              locale = Locale.fromSubtags(
                  languageCode: l.languageCode,
                  scriptCode: l.scriptCode,
                  countryCode: l.countryCode);
            }
          });

          return locale;
        },
        onGenerateRoute: RouterConfig.onGenerateRoute,
        builder: (BuildContext context, Widget? child) {
          return FlutterSmartDialog(child: child);
        },
      );
    });
  }
}
