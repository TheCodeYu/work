import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:work/constants/my_theme.dart';

/// description:可隐藏的listItem
///
/// user: yuzhou
/// date: 2021/6/19

class DisplayOption {
  final String title;
  final String subtitle;

  DisplayOption(this.title, {this.subtitle = ''});

  @override
  String toString() {
    return 'DisplayOption{title: $title, subtitle: $subtitle}';
  }
}

class OptionsListItem<T> extends StatefulWidget {
  OptionsListItem(
      {Key? key,
        required this.optionsMap,
        required this.title,
        required this.selectedOption,
        required this.onOptionChanged,
        required this.onTap,
        required this.isExpanded})
      : super(key: key);

  final LinkedHashMap<T, DisplayOption> optionsMap;
  final String title;
  final T selectedOption;
  final ValueChanged<T> onOptionChanged;
  final Function onTap;
  final bool isExpanded;

  @override
  _OptionsListItemState createState() => _OptionsListItemState<T>();
}

class _OptionsListItemState<T> extends State<OptionsListItem<T>>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
  CurveTween(curve: Curves.easeIn);
  static const _expandDuration = Duration(milliseconds: 150);
  // Common constants between SlowMotionSetting and SettingsListItem.
  final settingItemBorderRadius = BorderRadius.circular(10);
  static const settingItemHeaderMargin =
  EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8);

  late AnimationController _controller;
  late Animation<double> _childrenHeightFactor;
  late Animation<double> _headerChevronRotation;
  late Animation<double> _headerSubtitleHeight;
  late Animation<EdgeInsetsGeometry> _headerMargin;
  late Animation<EdgeInsetsGeometry> _headerPadding;
  late Animation<EdgeInsetsGeometry> _childrenPadding;
  late Animation<BorderRadius> _headerBorderRadius;

  // For ease of use. Correspond to the keys and values of `widget.optionsMap`.
  late Iterable<T> _options;
  late Iterable<DisplayOption> _displayOptions;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _expandDuration, vsync: this);
    _childrenHeightFactor = _controller.drive(_easeInTween);
    _headerChevronRotation =
        Tween<double>(begin: 0, end: 0.5).animate(_controller);
    _headerMargin = EdgeInsetsGeometryTween(
      begin: settingItemHeaderMargin,
      end: EdgeInsets.zero,
    ).animate(_controller);
    _headerPadding = EdgeInsetsGeometryTween(
      begin: const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
      end: const EdgeInsetsDirectional.fromSTEB(32, 18, 32, 20),
    ).animate(_controller);
    _headerSubtitleHeight =
        _controller.drive(Tween<double>(begin: 1.0, end: 0.0));
    _childrenPadding = EdgeInsetsGeometryTween(
      begin: const EdgeInsets.symmetric(horizontal: 32),
      end: EdgeInsets.zero,
    ).animate(_controller);
    _headerBorderRadius = BorderRadiusTween(
      begin: settingItemBorderRadius,
      end: BorderRadius.zero,
    ).animate(_controller);

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }

    _options = widget.optionsMap.keys;
    _displayOptions = widget.optionsMap.values;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleExpansion() {
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse().then<void>((value) {
        if (!mounted) {
          return;
        }
      });
    }
  }

  Widget _buildHeaderWithChildren(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CategoryHeader(
          margin: _headerMargin.value,
          padding: _headerPadding.value,
          borderRadius: _headerBorderRadius.value,
          subtitleHeight: _headerSubtitleHeight,
          chevronRotation: _headerChevronRotation,
          title: widget.title,
          subtitle: widget.optionsMap[widget.selectedOption]?.title ?? '',
          onTap: () => widget.onTap(),
        ),
        Padding(
          padding: _childrenPadding.value,
          child: ClipRect(
            child: Align(
              heightFactor: _childrenHeightFactor.value,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _handleExpansion();
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildHeaderWithChildren,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 384),
        margin: const EdgeInsetsDirectional.only(start: 24, bottom: 40),
        decoration: BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(
              width: 2,
              color: MyThemeData.primaryBackground,
            ),
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.isExpanded ? _options.length : 0,
          itemBuilder: (context, index) {
            final displayOption = _displayOptions.elementAt(index);
            return Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(style: BorderStyle.solid))),
              child: RadioListTile<T>(
                value: _options.elementAt(index),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayOption.title,
                    ),
                    Text(
                      displayOption.subtitle,
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                groupValue: widget.selectedOption,
                onChanged: (newOption) => widget.onOptionChanged(newOption!),
                dense: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    Key? key,
    required this.margin,
    required this.padding,
    required this.borderRadius,
    required this.subtitleHeight,
    required this.chevronRotation,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final String title;
  final String subtitle;
  final Animation<double> subtitleHeight;
  final Animation<double> chevronRotation;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(style: BorderStyle.solid))),
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title),
                          SizeTransition(
                            sizeFactor: subtitleHeight,
                            child: Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 8,
                      end: 24,
                    ),
                    child: RotationTransition(
                      turns: chevronRotation,
                      child: const Icon(Icons.chevron_right),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

/// Animate the settings list items to stagger in from above.
class AnimateSettingsListItems extends StatelessWidget {
  const AnimateSettingsListItems({
    Key? key,
    required this.animation,
    required this.children,
  }) : super(key: key);

  final Animation<double> animation;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dividingPadding = 4.0;
    final topPaddingTween = Tween<double>(
      begin: 0,
      end: children.length * dividingPadding,
    );
    final dividerTween = Tween<double>(
      begin: 0,
      end: dividingPadding,
    );

    return Padding(
      padding: EdgeInsets.only(top: topPaddingTween.animate(animation).value),
      child: Column(
        children: [
          for (Widget child in children)
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: dividerTween.animate(animation).value,
                  ),
                  child: child,
                );
              },
              child: child,
            ),
        ],
      ),
    );
  }
}

DisplayOption getLocaleDisplayOption(BuildContext context, Locale locale) {
  // TODO: gsw, fil, and es_419 aren't in flutter_localized_countries' dataset
  final localeCode = locale.toString();
  final localeName = LocaleNames.of(context)!.nameOf(localeCode);
  if (localeName != null) {
    final localeNativeName =
    LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeCode];
    return localeNativeName != null
        ? DisplayOption(localeNativeName, subtitle: localeName)
        : DisplayOption(localeName);
  } else {
    switch (localeCode) {
      case 'gsw':
        return DisplayOption('Schwiizertüütsch', subtitle: 'Swiss German');
      case 'fil':
        return DisplayOption('Filipino', subtitle: 'Filipino');
      case 'es_419':
        return DisplayOption(
          'español (Latinoamérica)',
          subtitle: 'Spanish (Latin America)',
        );
    }
  }

  return DisplayOption(localeCode);
}

/// Create a sorted — by native name – map of supported locales to their
/// intended display string, with a system option as the first element.
LinkedHashMap<Locale, DisplayOption> _getLocaleOptions(BuildContext context) {
  var localeOptions = LinkedHashMap<Locale, DisplayOption>.of({
    //Locale('system'): DisplayOption(locale(context).auto),
  });
  var supportedLocales = List<Locale>.from(AppLocalizations.supportedLocales);

  final displayLocales = Map<Locale, DisplayOption>.fromIterable(
    supportedLocales,
    value: (dynamic locale) =>
        getLocaleDisplayOption(context, locale as Locale),
  ).entries.toList()
    ..sort((l1, l2) => compareAsciiUpperCase(l1.value.title, l2.value.title));

  localeOptions.addAll(LinkedHashMap.fromEntries(displayLocales));
  return localeOptions;
}