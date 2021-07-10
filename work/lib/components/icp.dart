import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work/utils/adaptive.dart';

class ICP extends StatelessWidget {
  const ICP({Key? key}) : super(key: key);

  void tap(){
    print(1111);
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: isDisplayDesktop(context)?EdgeInsets.zero:EdgeInsets.only(bottom: kToolbarHeight),
      height: 75,
      color: Colors.transparent,
      child: ListView(
        children: [
          Text.rich(TextSpan(text: '© 2018-2019 风宇工作室 版权所有')),
          Text.rich(TextSpan(text: '鄂ICP备2021012206号',recognizer: TapGestureRecognizer()..onTap=tap)),
          Text.rich(TextSpan(text: '©  川公网安备 51011402000164号')),
        ],
      ),
    );
  }
}
