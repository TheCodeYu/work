import 'package:work/blocs/global/global_bloc.dart';
import 'package:work/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'painter.dart';

class Splash extends StatefulWidget {
  final double size;
  static final defaultRoute = 'splash_page';
  const Splash({this.size = 200});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _factor = 0;
  late Animation _curveAnim;

  bool _animEnd = false;

  double progress = 0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() => setState(() {
                return _factor = _curveAnim.value;
              }))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              BlocProvider.of<GlobalBloc>(context).add(EventIntoHome());
              Navigator.of(context).pushReplacementNamed(HomePage.defaultRoute);
            }
          });

    _curveAnim =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var winH = MediaQuery.of(context).size.height;
    var winW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildLogo(Colors.blue),
          Container(
            width: winW,
            height: winH,
            child: CustomPaint(
              painter: Painter(factor: _factor),
            ),
          ),
          buildText(winH, winW),
          buildHead(),
          buildPower(),
          Column(
            children: [
              Expanded(child: SizedBox()),
              LinearProgressIndicator(
                value: progress,
                //color: Colors.grey,
                // backgroundColor: Colors.transparent,
              )
            ],
          )
        ],
      ),
    );
  }

  Positioned buildText(double winH, double winW) {
    final shadowStyle = TextStyle(
      fontSize: 45,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      shadows: [
        const Shadow(
          color: Colors.grey,
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
        )
      ],
    );

    return Positioned(
      top: winH / 1.4,
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _animEnd ? 1.0 : 0.0,
          child: Text(
            'Feng Yu',
            style: shadowStyle,
          )),
    );
  }

  final colors = [Colors.red, Colors.yellow, Colors.blue];

  Widget buildLogo(Color primaryColor) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0, -1.5),
      ).animate(_controller),
      child: RotationTransition(
          turns: _controller,
          child: ScaleTransition(
            scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
            child: FadeTransition(
                opacity: _controller,
                child: Container(
                  height: 120,
                  child: FlutterLogo(
//                    colors: primaryColor,
                    size: 60,
                  ),
                )),
          )),
    );
  }

  Widget buildHead() => SlideTransition(
      position: Tween<Offset>(
        end: const Offset(0, 0),
        begin: const Offset(0, -5),
      ).animate(_controller),
      child: Container(
        height: 45,
        width: 45,
        child: Image.asset('assets/images/icon_head.webp'),
      ));

  Widget buildPower() => Positioned(
        bottom: 30,
        right: 30,
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _animEnd ? 1.0 : 0.0,
            child: const Text("Power By FengYu Studio",
                style: TextStyle(
                    color: Colors.grey,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(0.3, 0.3))
                    ],
                    fontSize: 16))),
      );
}
