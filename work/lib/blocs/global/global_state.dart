part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final String fontFamily;
  final MaterialColor themeColor;
  final bool showBackGround;
  final int codeStyleIndex;
  final int itemStyleIndex;
  final Locale locale;
  final AppUI? appUI;

  GlobalState(
      {this.appUI,
      this.fontFamily = 'ComicNeue',
      this.themeColor = Colors.blue,
      this.showBackGround = true,
      this.codeStyleIndex = 0,
      this.itemStyleIndex = 0,
      this.locale = const Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN')});
  @override
  List<Object?> get props => [
        fontFamily,
        themeColor,
        showBackGround,
        codeStyleIndex,
        itemStyleIndex,
        locale,
        appUI,
      ];

  GlobalState copyWith(
          {String? fontFamily,
          MaterialColor? themeColor,
          bool? showBackGround,
          int? codeStyleIndex,
          int? itemStyleIndex,
          Locale? locale,
          AppUI? appUI}) =>
      GlobalState(
          fontFamily: fontFamily ?? this.fontFamily,
          themeColor: themeColor ?? this.themeColor,
          showBackGround: showBackGround ?? this.showBackGround,
          codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
          itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
          locale: locale ?? this.locale,
          appUI: appUI ?? this.appUI);

  @override
  String toString() {
    return 'GlobalState{ fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex},localeIndex:$locale,appUI:$appUI';
  }
}
