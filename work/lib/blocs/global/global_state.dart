part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final String fontFamily;
  final MaterialColor themeColor;
  final bool showBackGround;
  final int codeStyleIndex;
  final int itemStyleIndex;
  final Locale? locale;
  final double textScaleFactor;
  final TargetPlatform platform;
  final ThemeMode themeMode;
  GlobalState({
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.showBackGround = true,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.locale,
    this.textScaleFactor = systemTextScaleFactorOption,
    this.platform = TargetPlatform.android,
    this.themeMode = ThemeMode.system,
  });
  @override
  List<Object?> get props => [
        fontFamily,
        themeColor,
        showBackGround,
        codeStyleIndex,
        itemStyleIndex,
        locale,
        textScaleFactor,
        platform,
        themeMode
      ];

  GlobalState copyWith(
          {String? fontFamily,
          MaterialColor? themeColor,
          bool? showBackGround,
          int? codeStyleIndex,
          int? itemStyleIndex,
          Locale? locale,
          double? textScaleFactor,
          TargetPlatform? platform,
          ThemeMode? themeMode}) =>
      GlobalState(
          fontFamily: fontFamily ?? this.fontFamily,
          themeColor: themeColor ?? this.themeColor,
          showBackGround: showBackGround ?? this.showBackGround,
          codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
          itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
          locale: locale ?? this.locale,
          textScaleFactor: textScaleFactor ?? this.textScaleFactor,
          platform: platform ?? this.platform,
          themeMode: themeMode ?? this.themeMode);

  @override
  String toString() {
    return 'GlobalState{fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex, locale: $locale, textScaleFactor: $textScaleFactor, platform: $platform, themeMode:$themeMode}';
  }
}
