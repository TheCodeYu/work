import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work/blocs/global/global_bloc.dart';
import 'package:work/components/bottom_drawer.dart';
import 'package:work/components/label_button.dart';
import 'package:work/components/options_items.dart';
import 'package:work/components/waterfall_notched.rectangle.dart';
import 'package:work/constants/my_theme.dart';
import 'package:work/pages/home.dart';

///手机等小屏适配
///
///
const _kAnimationDuration = Duration(milliseconds: 300);
const double _kFlingVelocity = 2.0;

class MobileNav extends StatefulWidget {
  const MobileNav(
      {Key? key,
      required this.destinations,
      required this.onItemTapped,
      required this.selected,
      required this.child})
      : super(key: key);

  final List<RallyTab> destinations;
  final void Function(int) onItemTapped;
  final int selected;
  final Widget child;
  @override
  _MobileNavState createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> with TickerProviderStateMixin {
  final _bottomDrawerKey = GlobalKey(debugLabel: 'Bottom Drawer');
  late AnimationController _drawerController;
  late AnimationController _dropArrowController;
  late AnimationController _bottomAppBarController;
  late Animation<double> _drawerCurve;
  late Animation<double> _dropArrowCurve;
  late Animation<double> _bottomAppBarCurve;

  @override
  void initState() {
    super.initState();

    _drawerController = AnimationController(
      duration: _kAnimationDuration,
      value: 0,
      vsync: this,
    )..addListener(() {
        if (_drawerController.value < 0.01) {
          setState(() {
            //Reload state when drawer is at its smallest to toggle visibility
            //If state is reloaded before this drawer closes abruptly instead
            //of animating.
          });
        }
      });

    _drawerCurve = CurvedAnimation(
      parent: _drawerController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _dropArrowController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );

    _bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );

    _dropArrowCurve = CurvedAnimation(
      parent: _dropArrowController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _bottomAppBarCurve = CurvedAnimation(
      parent: _bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _dropArrowController.dispose();
    _bottomAppBarController.dispose();
    super.dispose();
  }

  bool onSearchPage = false;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        switch (notification.direction) {
          case ScrollDirection.forward:
            _bottomAppBarController.forward();
            break;
          case ScrollDirection.reverse:
            _bottomAppBarController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  bool get _bottomDrawerVisible {
    final status = _drawerController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  double get _bottomDrawerHeight {
    final renderBox =
        _bottomDrawerKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  void _toggleBottomDrawerVisibility() {
    if (_drawerController.value < 0.4) {
      _drawerController.animateTo(0.4, curve: standardEasing);
      _dropArrowController.animateTo(0.35, curve: standardEasing);
      return;
    }

    _dropArrowController.forward();
    _drawerController.fling(
      velocity: _bottomDrawerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _drawerController.value -= details.primaryDelta! / _bottomDrawerHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drawerController.isAnimating ||
        _drawerController.status == AnimationStatus.completed) {
      return;
    }

    final flingVelocity =
        details.velocity.pixelsPerSecond.dy / _bottomDrawerHeight;

    if (flingVelocity < 0.0) {
      _drawerController.fling(
        velocity: math.max(_kFlingVelocity, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      _dropArrowController.forward();
      _drawerController.fling(
        velocity: math.min(-_kFlingVelocity, -flingVelocity),
      );
    } else {
      if (_drawerController.value < 0.6) {
        _dropArrowController.forward();
      }
      _drawerController.fling(
        velocity:
            _drawerController.value < 0.6 ? -_kFlingVelocity : _kFlingVelocity,
      );
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final drawerSize = constraints.biggest;
    final drawerTop = drawerSize.height;

    final drawerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, drawerTop, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_drawerCurve);

    return Stack(clipBehavior: Clip.none, key: _bottomDrawerKey, children: [
      NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [widget.child],
              ))),
      GestureDetector(
        onTap: () {
          _drawerController.reverse();
          _dropArrowController.reverse();
        },
        child: Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: _bottomDrawerVisible,
          child: FadeTransition(
            opacity: _drawerCurve,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

            ),
          ),
        ),
      ),
      PositionedTransition(
        rect: drawerAnimation,
        child: Visibility(
          visible: _bottomDrawerVisible,
          child: BottomDrawer(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            leading: _BottomDrawerDestinations(
                destinations: widget.destinations,
                drawerController: _drawerController,
                dropArrowController: _dropArrowController,
                onItemTapped: widget.onItemTapped,
                selected: widget.selected),
            //trailing: _BottomDrawerFolderSection(folders: widget.folders),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _SharedAxisTransitionSwitcher(
      defaultChild: Scaffold(
        backgroundColor: MyThemeData.primaryBackground,
        extendBody: true,
        body: LayoutBuilder(
          builder: _buildStack,
        ),
        bottomNavigationBar: _AnimatedBottomAppBar(
          bottomAppBarController: _bottomAppBarController,
          bottomAppBarCurve: _bottomAppBarCurve,
          bottomDrawerVisible: _bottomDrawerVisible,
          dropArrowCurve: _dropArrowCurve,
          drawerController: _drawerController,
          navigationDestinations: widget.destinations,
          selected: widget.selected,
          toggleBottomDrawerVisibility: _toggleBottomDrawerVisibility,
        ),
        floatingActionButton: _bottomDrawerVisible ? null :
        const Padding(
                padding: EdgeInsetsDirectional.only(bottom: 8),
                child: _ReplyFab(),
              ),
      ),
      onSearchPage: onSearchPage,
    );
  }
}

class _BottomDrawerDestinations extends StatelessWidget {
  const _BottomDrawerDestinations({
    required this.destinations,
    required this.drawerController,
    required this.dropArrowController,
    required this.onItemTapped,
    required this.selected,
  });

  final int selected;
  final List<RallyTab> destinations;
  final AnimationController drawerController;
  final AnimationController dropArrowController;

  final void Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    final destinationButtons = <Widget>[];

    for (var index = 0; index < destinations.length; index += 1) {
      var destination = destinations[index];
      destinationButtons.add(
        InkWell(
          key: ValueKey('Reply-${destination.titleText}'),
          onTap: () {
            drawerController.reverse();
            dropArrowController.forward();
            Future.delayed(
              Duration(milliseconds: (drawerController.value == 1 ? 300 : 120)),
              () {
                // Wait until animations are complete to reload the state.
                // Delay scales with the timeDilation value of the gallery.
                onItemTapped(index);
              },
            );
          },
          child:
              ListTile(leading: destination.icon, title: destination.titleText),
        ),
      );
    }

    return Column(
      children: destinationButtons,
    );
  }
}

class _ReplyFab extends StatefulWidget {
  const _ReplyFab();

  @override
  _ReplyFabState createState() => _ReplyFabState();
}

class _ReplyFabState extends State<_ReplyFab>
    with SingleTickerProviderStateMixin {
  static const double _mobileFabDimension = 56;

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder();

    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return const TTT(t: "111");
      },
      openColor: theme.cardColor,
      closedShape: circleFabBorder,
      closedColor: theme.colorScheme.secondary,
      closedElevation: 6,
      closedBuilder: (context, openContainer) {
        return Tooltip(
          message: 'Reply',
          child: InkWell(
            key: const ValueKey('ReplyFab'),
            customBorder: circleFabBorder,
            onTap: openContainer,
            child: SizedBox(
              height: _mobileFabDimension,
              width: _mobileFabDimension,
              child: Center(
                child: _FadeThroughTransitionSwitcher(
                  fillColor: Colors.transparent,
                  child: const Icon(
                    Icons.create,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SharedAxisTransitionSwitcher extends StatelessWidget {
  const _SharedAxisTransitionSwitcher({
    required this.defaultChild,
    required this.onSearchPage,
  });

  final Widget defaultChild;

  final bool onSearchPage;
  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: !onSearchPage,
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          fillColor: MyThemeData.primaryBackground,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          child: child,
        );
      },
      child: onSearchPage ? const SearchPage() : defaultChild,
    );
  }
}

class _FadeThroughTransitionSwitcher extends StatelessWidget {
  const _FadeThroughTransitionSwitcher({
    required this.fillColor,
    required this.child,
  });

  final Widget child;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          fillColor: fillColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _AnimatedBottomAppBar extends StatelessWidget {
  const _AnimatedBottomAppBar({
    required this.bottomAppBarController,
    required this.bottomAppBarCurve,
    required this.bottomDrawerVisible,
    required this.dropArrowCurve,
    required this.navigationDestinations,
    required this.toggleBottomDrawerVisibility,
    required this.drawerController,
    required this.selected,
  });

  final int selected;
  final AnimationController bottomAppBarController;
  final AnimationController drawerController;
  final Animation<double> bottomAppBarCurve;
  final bool bottomDrawerVisible;
  final Animation<double> dropArrowCurve;
  final List<RallyTab> navigationDestinations;
  final ui.VoidCallback toggleBottomDrawerVisibility;

  @override
  Widget build(BuildContext context) {
    var l = getLocaleDisplayOption(context, BlocProvider.of<GlobalBloc>(context).state.locale??Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
        countryCode: 'CN'));
    bottomAppBarController.forward();
    return SizeTransition(
      sizeFactor: bottomAppBarCurve,
      axisAlignment: -1,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 2),
        child: BottomAppBar(
          color: MyThemeData.primaryBackground,
          shape: const WaterfallNotchedRectangle(),
          notchMargin: 6,
          child: Container(
            color: Colors.transparent,
            height: kToolbarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  key: const ValueKey('navigation_button'),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: toggleBottomDrawerVisibility,
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      RotationTransition(
                        turns: Tween(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(dropArrowCurve),
                        child: const Icon(
                          Icons.arrow_drop_up,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const ImageIcon(
                        AssetImage(
                          'images/reply_logo.png',
                        ),
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      _FadeThroughTransitionSwitcher(
                        fillColor: Colors.transparent,
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 1, end: -1).animate(
                            drawerController
                                .drive(CurveTween(curve: standardEasing)),
                          ),
                          child:
                              navigationDestinations.firstWhere((destination) {
                            return destination.tabIndex == selected;
                          }).titleText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: _FadeThroughTransitionSwitcher(
                        fillColor: Colors.transparent,
                        child: bottomDrawerVisible
                            ? Align(
                                key: UniqueKey(),
                                alignment: Alignment.centerRight,
                                child: MyLabel(label: Text(l.title), onPressed: (){},backgroundColor: MyThemeData.primaryBackground,),
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: MyLabel(label: Text.rich(TextSpan(text: '注册/登录')), onPressed: (){
                                },backgroundColor: MyThemeData.primaryBackground,),
                              )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('search'),
    );
  }
}
