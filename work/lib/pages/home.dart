import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work/blocs/global/global_bloc.dart';
import 'package:work/components/icp.dart';
import 'package:work/components/label_button.dart';
import 'package:work/components/mobile_nav.dart';
import 'package:work/components/options_items.dart';
import 'package:work/config/i10n.dart';
import 'package:work/constants/my_theme.dart';
import 'package:work/pages/studio_page.dart';
import 'package:work/utils/adaptive.dart';

const int tabCount = 5;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;
const double logoSize = 120;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDesktop = isDisplayDesktop(context);

    Widget tabBarView = Container();

    ///自动适配
    if (isDesktop) {
      tabBarView = Column(
        children: [
          Row(
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  height: logoSize,
                  width: logoSize,
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
              ),
              _RallyTabBar(
                tabs: _buildTabs(context, theme),
                tabController: _tabController,
              ),
            ],
          ),
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
    return [
      RallyTab(
        theme: theme,
        iconData: Icons.pie_chart,
        title: locale(context).titleOverview,
        tabIndex: 0,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        theme: theme,
        iconData: Icons.attach_money,
        title: locale(context).titleAccounts,
        tabIndex: 1,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        theme: theme,
        iconData: Icons.money_off,
        title: locale(context).titleBills,
        tabIndex: 2,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        theme: theme,
        iconData: Icons.table_chart,
        title: locale(context).titleBudgets,
        tabIndex: 3,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      RallyTab(
        theme: theme,
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
  const _RallyTabBar(
      {Key? key, required this.tabs, required this.tabController})
      : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    // print(_getLocaleOptions(context));
    var l = getLocaleDisplayOption(
        context,
        BlocProvider.of<GlobalBloc>(context).state.locale ??
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'));
    return FocusTraversalOrder(
      order: const NumericFocusOrder(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                MyLabel(
                  label: Text.rich(TextSpan(text: '注册/登录')),
                  onPressed: () {},
                  backgroundColor: MyThemeData.primaryBackground,
                ),
                SizedBox(
                  width: 5,
                ),
                MyLabel(
                  label: Text(l.title),
                  onPressed: () {},
                  backgroundColor: MyThemeData.primaryBackground,
                ),
              ],
            ),
          ),
          TabBar(
            // Setting isScrollable to true prevents the tabs from being
            // wrapped in [Expanded] widgets, which allows for more
            // flexible sizes and size animations among tabs.
            isScrollable: true,
            labelPadding: EdgeInsets.zero,
            tabs: tabs,
            controller: tabController,
            // This hides the tab indicator.
            indicatorColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}

class RallyTab extends StatefulWidget {
  RallyTab({
    required ThemeData theme,
    required IconData iconData,
    required String title,
    required int tabIndex,
    required TabController tabController,
    required this.isVertical,
  })  : titleText = Text(title, style: theme.textTheme.button),
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
    final width = MediaQuery.of(context).size.width - logoSize;
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
