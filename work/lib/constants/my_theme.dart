import 'package:flutter/material.dart';
import 'package:work/blocs/global/global_bloc.dart';

class MyThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData(state) =>
      themeData(state, lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData(state) =>
      themeData(state, darkColorScheme, _darkFocusColor);

  static ThemeData themeData(
      GlobalState state, ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      primarySwatch: Colors.blue,
      fontFamily: state.fontFamily,
      textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
      primaryColor: colorScheme.onPrimary,
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.blue,
    primaryVariant: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFEF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryVariant: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static get _textTheme => TextTheme(
        headline4: TextStyle(fontWeight: _bold, fontSize: 20.0),
        caption: TextStyle(fontWeight: _semiBold, fontSize: 16.0),
        headline5: TextStyle(fontWeight: _medium, fontSize: 16.0),
        subtitle1: TextStyle(fontWeight: _medium, fontSize: 16.0),
        overline: TextStyle(fontWeight: _medium, fontSize: 12.0),
        bodyText1: TextStyle(fontWeight: _regular, fontSize: 14.0),
        subtitle2: TextStyle(fontWeight: _medium, fontSize: 14.0),
        bodyText2: TextStyle(fontWeight: _regular, fontSize: 16.0),
        headline6: TextStyle(fontWeight: _bold, fontSize: 16.0),
        button: TextStyle(fontWeight: _semiBold, fontSize: 14.0),
      ).apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      );
}
