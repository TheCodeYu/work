import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work/utils/adaptive.dart';

class ICP extends StatelessWidget {
  const ICP({Key? key}) : super(key: key);
  static const _url_gov = 'https://beian.miit.gov.cn/';
  static const _url_home = 'https://www.4mychip.com/';
  static const _url_police = 'https://www.4mychip.com/';
  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Container(
        margin: isDesktop
            ? EdgeInsets.zero
            : EdgeInsets.only(bottom: kToolbarHeight),
        height: isDesktop ? 50 : 75,
        color: Colors.transparent,
        child: ListView(
          scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Text.rich(
                TextSpan(
                    text: '© 2021-2022 风宇工作室 版权所有',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(_url_home)),
              ),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                    text: '鄂ICP备2021012206号',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(_url_gov)),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/webLog.png'),
                  Text.rich(TextSpan(
                      text: '川公网安备 51011402000164号',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(_url_gov)))
                ],
              ),
            )
          ],
        ));
  }
}
