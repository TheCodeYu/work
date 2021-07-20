import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work/config/i10n.dart';
import 'package:work/components/dialog/about.dart' as about;
import 'package:work/utils/adaptive.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingsLink(
      title: locale(context).settingsAbout,
      icon: Icons.info_outline,
      onTap: () {
        about.showAboutDialog(context: context);
      },
    );
  }
}

class SettingsFeedback extends StatelessWidget {
  const SettingsFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingsLink(
      title: locale(context).settingsFeedback,
      icon: Icons.feedback,
      onTap: () async {
        const url = 'https://github.com/flutter/flutter/issues/new/choose/';
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: false,
          );
        }
      },
    );
  }
}

class SettingsAttribution extends StatelessWidget {
  const SettingsAttribution({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final verticalPadding = isDesktop ? 0.0 : 28.0;
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: isDesktop ? 24 : 32,
          end: isDesktop ? 0 : 32,
          top: verticalPadding,
          bottom: verticalPadding,
        ),
        child: Text(
          locale(context).settingsAttribution,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          textAlign: isDesktop ? TextAlign.end : TextAlign.start,
        ),
      ),
    );
  }
}

class _SettingsLink extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback onTap;

  const _SettingsLink(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : 32,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: colorScheme.onSecondary.withOpacity(0.5),
              size: 24,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 16,
                  top: 12,
                  bottom: 12,
                ),
                child: Text(
                  title,
                  style: textTheme.subtitle2?.apply(
                    color: colorScheme.onSecondary,
                  ),
                  textAlign: isDesktop ? TextAlign.end : TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
