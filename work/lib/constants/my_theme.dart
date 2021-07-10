
import 'package:flutter/material.dart';
import 'package:work/blocs/global/global_bloc.dart';

class MyThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const Color gray = Color(0xFFD8D8D8);
  static const Color gray60 = Color(0x99D8D8D8);
  static const Color gray25 = Color(0x40D8D8D8);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color primaryBackground = Color(0xFF33333D);
  static const Color inputBackground = Color(0xFF26282F);
  static const Color cardBackground = Color(0x03FEFEFE);
  static const Color buttonColor = Color(0xFF09AF79);
  static const Color focusColor = Color(0xCCFFFFFF);
  static const Color dividerColor = Color(0xAA282828);


  static ThemeData lightThemeData(state)=>
  themeData(state,lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData(state) => themeData(state,darkColorScheme, _darkFocusColor);

  static ThemeData themeData(GlobalState state,ColorScheme colorScheme, Color focusColor) {

    return
      ThemeData(
        appBarTheme: const AppBarTheme(brightness: Brightness.dark, elevation: 0),
        scaffoldBackgroundColor: primaryBackground,
        primaryColor: primaryBackground,
        focusColor: focusColor,
        textTheme: _textTheme(state),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: gray,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: inputBackground,
          focusedBorder: InputBorder.none,
        ),
        visualDensity: VisualDensity.standard,
      );
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme(state),
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        textTheme: _textTheme(state).apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
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
        contentTextStyle: _textTheme(state).subtitle1!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
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
    primary: Color(0xFFFF8383),
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

  static TextTheme _textTheme(GlobalState state) => TextTheme(
    headline4: TextStyle(fontFamily: state.fontFamily, fontWeight: _bold, fontSize: 20.0),
    caption: TextStyle(fontFamily: state.fontFamily,fontWeight: _semiBold, fontSize: 16.0),
    headline5: TextStyle(fontFamily: state.fontFamily,fontWeight: _medium, fontSize: 16.0),
    subtitle1: TextStyle(fontFamily: state.fontFamily,fontWeight: _medium, fontSize: 16.0),
    overline: TextStyle(fontFamily: state.fontFamily,fontWeight: _medium, fontSize: 12.0),
    bodyText1: TextStyle(fontFamily: state.fontFamily,fontWeight: _regular, fontSize: 14.0),
    subtitle2: TextStyle(fontFamily: state.fontFamily,fontWeight: _medium, fontSize: 14.0),
    bodyText2: TextStyle(fontFamily: state.fontFamily,fontWeight: _regular, fontSize: 16.0),
    headline6: TextStyle(fontFamily: state.fontFamily,fontWeight: _bold, fontSize: 16.0),
    button: TextStyle(fontFamily: state.fontFamily,fontWeight: _semiBold, fontSize: 14.0),
  ).apply(
    displayColor: Colors.white,
    bodyColor: Colors.white,
  );
}
