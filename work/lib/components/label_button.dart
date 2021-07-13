import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyLabel extends StatefulWidget {
  MyLabel({
    var key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);
  final Widget label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  _MyMyLabelState createState() => _MyMyLabelState();
}

class _MyMyLabelState extends State<MyLabel> {
  Color chipColor = Colors.white;
  void _enter(PointerEnterEvent details) {
    setState(() {
      chipColor = Color.fromRGBO(0, 0, 255, 1);
    });
  }

  void _exit(PointerExitEvent details) {
    setState(() {
      chipColor = Colors.white;
    });
  }

  void _hover(PointerHoverEvent details) {
    setState(() {
      chipColor = Color.fromRGBO(0, 0, 255, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    //chipColor = Theme.of(context).primaryColorLight;
    return MouseRegion(
      onEnter: _enter,
      onExit: _exit,
      onHover: _hover,
      child: RawChip(
        label: widget.label,
        elevation: 2,
        pressElevation: 8, //点击时凸起效果
        backgroundColor: widget.backgroundColor ?? Colors.blue,
        onPressed: widget.onPressed,
        labelStyle: TextStyle(
          color: chipColor,
        ),
      ),
    );
  }
}
