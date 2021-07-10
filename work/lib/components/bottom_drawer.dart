import 'package:flutter/material.dart';
import 'package:work/components/icp.dart';
import 'package:work/constants/my_theme.dart';

class BottomDrawer extends StatelessWidget {
  const BottomDrawer({
    Key? key,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
    required this.leading,
    this.trailing,
  }) : super(key: key);

  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child:Scaffold(
            backgroundColor: Color(0xFF344955),
            body:  ListView(
              padding: const EdgeInsets.all(12),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 28),
                leading,
                const SizedBox(height: 8),
                const Divider(
                  color: MyThemeData.gray,
                  thickness: 0.25,
                  indent: 18,
                  endIndent: 160,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 18),
                  child: Text(
                    'FOLDERS',
                  ),
                ),
                const SizedBox(height: 4),
                trailing ?? const SizedBox(height: 4),
              ],
            ),
           // bottomNavigationBar:  ICP(),

          )
      )
    );
  }
}
