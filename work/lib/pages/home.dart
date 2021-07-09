import 'package:work/components/tools/title_bar.dart';
import 'package:work/components/tools/tools_bar.dart';
import 'package:work/constants/cons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final defaultRoute = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            height: Cons.titleBarHeight,
            color: Colors.indigo.withOpacity(0.6),
            child: TitleBar()),
        Expanded(
            child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/os/images/bg.jpg',
                fit: BoxFit.fill,
              ),
            ),
            // Visibility(
            //   visible: true,

            //   ///直接不渲染
            //   child: Column(
            //     children: [
            //       const Expanded(
            //         child: SizedBox(),
            //       ),
            //     ],
            //   ),
            // )
          ],
        )),
      ]),
    );
  }
}
