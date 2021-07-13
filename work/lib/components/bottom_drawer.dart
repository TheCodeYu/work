import 'package:flutter/material.dart';
import 'package:work/components/icp.dart';

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
            child: Scaffold(
              body: ListView(
                padding: const EdgeInsets.all(12),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 28),
                  leading,
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 1,
                    indent: 18,
                    endIndent: 160,
                  ),
                  const SizedBox(height: 4),
                  trailing ?? const SizedBox(height: 4),
                ],
              ),
              bottomNavigationBar: ICP(),
            )));
  }
}
