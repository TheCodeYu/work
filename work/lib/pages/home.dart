import 'dart:collection';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work/blocs/global/global_bloc.dart';
import 'package:work/components/button/my_tool_tip.dart';
import 'package:work/components/icp.dart';
import 'package:work/components/label_button.dart';
import 'package:work/components/mobile_nav.dart';
import 'package:work/components/options_items.dart';
import 'package:work/config/i10n.dart';
import 'package:work/pages/login.dart';
import 'package:work/pages/studio_page.dart';
import 'package:work/utils/adaptive.dart';

const int tabCount = 5;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String defaultRoute = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  RestorableInt tabIndex = RestorableInt(0);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabCount, vsync: this)
      ..addListener(() {
        // Set state to make sure that the [_RallyTab] widgets get updated when changing tabs.
        setState(() {
          tabIndex.value = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  Widget language() {
    var pro = BlocProvider.of<GlobalBloc>(context);
    var l = pro.state.locale ?? Locale.fromSubtags(languageCode: 'zh');

    LinkedHashMap<Locale, DisplayOption> temp = getLocaleOptions(context);
    List<PopupMenuItem<Locale>> list = List.empty(growable: true);
    temp.forEach((key, value) {
      list.add(CheckedPopupMenuItem<Locale>(
        checked: key == l,
        padding: EdgeInsets.zero,
        value: key,
        child: MyLabel(
          label: Text(value.title),
          onPressed: null,
        ),
      ));
    });
    return new PopupMenuButton<Locale>(
        child: MyLabel(
          label: Text(getLocaleDisplayOption(context, l).title),
          onPressed: null,
        ),
        itemBuilder: (BuildContext context) => list,
        onSelected: (Locale value) {
          pro.add(EventupdateSetting(value));
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDesktop = isDisplayDesktop(context);

    Widget tabBarView = Container();

    ///自动适配
    if (isDesktop) {
      tabBarView = Column(
        children: [
          _RallyTabBar(
              tabs: _buildTabs(context, theme),
              tabController: _tabController,
              language: language()),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _buildTabViews(),
            ),
          ),
          ICP()
        ],
      );
    } else {
      tabBarView = MobileNav(
        destinations: _buildTabs(context, theme),
        onItemTapped: _onDestinationSelected,
        selected: _tabController.index,
        language: language(),
        child: Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _buildTabViews(),
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        // For desktop layout we do not want to have SafeArea at the top and
        // bottom to display 100% height content on the accounts view.
        top: !isDesktop,
        bottom: !isDesktop,
        child: Theme(
          // This theme effectively removes the default visual touch
          // feedback for tapping a tab, which is replaced with a custom
          // animation.
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(), child: tabBarView),
        ),
      ),
    );
  }

  @override
  String? get restorationId => HomePage.defaultRoute;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  List<RallyTab> _buildTabs(BuildContext context, ThemeData theme,
      [bool isVertical = false]) {
    var style = isDisplayDesktop(context)
        ? TextStyle(color: Colors.white, fontSize: 24)
        : Theme.of(context).textTheme.subtitle1;
    return [
      RallyTab(
        style: style!,
        iconData: Icons.pie_chart,
        title: locale(context).titleOverview,
        tabIndex: 0,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        style: style,
        iconData: Icons.attach_money,
        title: locale(context).titleAccounts,
        tabIndex: 1,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        style: style,
        iconData: Icons.money_off,
        title: locale(context).titleBills,
        tabIndex: 2,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        style: style,
        iconData: Icons.table_chart,
        title: locale(context).titleBudgets,
        tabIndex: 3,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        style: style,
        iconData: Icons.settings,
        title: locale(context).titleSettings,
        tabIndex: 4,
        tabController: _tabController,
        isVertical: isVertical,
      ),
    ];
  }

  List<Widget> _buildTabViews() {
    return [
      StudioPage(),
      TTT(t: "2"),
      TTT(t: "3"),
      TTT(t: "4"),
      TTT(t: "5"),
    ];
  }

  void _onDestinationSelected(int index) {
    _tabController.index = index;
    setState(() {});
  }
}

class TTT extends StatefulWidget {
  const TTT({Key? key, required this.t}) : super(key: key);
  final String t;
  @override
  _TTTState createState() => _TTTState();
}

class _TTTState extends State<TTT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.t),
    );
  }
}

class _RallyTabBar extends StatelessWidget {
  _RallyTabBar(
      {Key? key,
      required this.tabs,
      required this.tabController,
      required this.language})
      : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;
  final Widget language;

  @override
  Widget build(BuildContext context) {
    // print(_getLocaleOptions(context));

    return FocusTraversalOrder(
      order: const NumericFocusOrder(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ///logo放这里
                TextLiquidFill(
                  loadDuration: const Duration(seconds: 10),
                  waveDuration: const Duration(seconds: 10),
                  text: locale(context).app,
                  waveColor: Colors.black,
                  boxBackgroundColor: Color(0xFFE6EBEB),
                  textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  boxHeight: 75.0,
                ),
                Expanded(child: SizedBox()),
                MyTooltip(
                  padding: EdgeInsets.zero,
                  message: Image.asset(
                    'images/qrcode_344.jpg',
                    width: 120,
                    height: 120,
                  ),
                  child: MyLabel(
                    label: Text.rich(TextSpan(text: locale(context).public)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                MyLabel(
                  label: Text.rich(TextSpan(text: locale(context).register)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginPage.defaultRoute);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                language
              ],
            ),
          ),
          Material(
            color: Color(0xff2196f3).withOpacity(0.8),
            child: TabBar(
              // Setting isScrollable to true prevents the tabs from being
              // wrapped in [Expanded] widgets, which allows for more
              // flexible sizes and size animations among tabs.

              isScrollable: true,
              labelPadding: EdgeInsets.zero,
              tabs: tabs,
              controller: tabController,
              // This hides the tab indicator.
              indicatorColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class RallyTab extends StatefulWidget {
  RallyTab({
    required TextStyle style,
    required IconData iconData,
    required String title,
    required int tabIndex,
    required TabController tabController,
    required this.isVertical,
  })  : titleText = Text(title, style: style),
        isExpanded = tabController.index == tabIndex,
        tabIndex = tabIndex,
        icon = Icon(iconData, semanticLabel: title);

  final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;
  final int tabIndex;
  @override
  RallyTabState createState() => RallyTabState();
}

class RallyTabState extends State<RallyTab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _titleSizeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _iconFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(RallyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVertical) {
      return Column(
        children: [
          const SizedBox(height: 18),
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: widget.icon,
          ),
          const SizedBox(height: 12),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.vertical,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: Center(child: ExcludeSemantics(child: widget.titleText)),
            ),
          ),
          const SizedBox(height: 18),
        ],
      );
    }

    // Calculate the width of each unexpanded tab by counting the number of
    // units and dividing it into the screen width. Each unexpanded tab is 1
    // unit, and there is always 1 expanded tab which is 1 unit + any extra
    // space determined by the multiplier.
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 2;
    final unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
          ),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(
                  child: ExcludeSemantics(child: widget.titleText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
