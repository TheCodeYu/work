import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:work/components/carouselCard.dart';
import 'package:work/components/category_item.dart';
import 'package:work/components/footer.dart';
import 'package:work/components/image_placeholder.dart';
import 'package:work/config/i10n.dart';
import 'package:work/model/data.dart';
import 'package:work/utils/adaptive.dart';

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;
const _horizontalDesktopPadding = 81.0;
const _carouselHeightMin = 200.0 + 2 * _carouselItemMargin;
const _desktopCardsPerPage = 4;

class ToggleSplashNotification extends Notification {}

///首页
///
///
class StudioPage extends StatefulWidget {
  const StudioPage({Key? key}) : super(key: key);

  @override
  _StudioPageState createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    final carouselCards = <Widget>[
      CarouselCard(
        asset: const AssetImage(
          'assets/studies/reply_card.png',
        ),
        assetColor: const Color(0xFF344955),
        subtitle: locale(context).desktop_d,
        title: locale(context).desktop,
      ),
      CarouselCard(
        asset: const AssetImage(
          'assets/studies/shrine_card.png',
        ),
        assetColor: const Color(0xFF344955),
        subtitle: locale(context).mobile_d,
        title: locale(context).mobile,
      ),
      CarouselCard(
        asset: const AssetImage(
          'assets/studies/rally_card.png',
        ),
        assetColor: const Color(0xFF344955),
        subtitle: locale(context).mini_d,
        title: locale(context).mini,
      ),
      CarouselCard(
        asset: const AssetImage(
          'assets/studies/crane_card.png',
        ),
        assetColor: const Color(0xFF344955),
        subtitle: locale(context).web_d,
        title: locale(context).web,
      ),
    ];
    if (isDesktop) {
      final desktopCategoryItems = <_DesktopCategoryItem>[
        _DesktopCategoryItem(
          category: CategoryData.material,
          asset: const AssetImage(
            'assets/images/material.png',
          ),
          data: [],
        ),
        _DesktopCategoryItem(
          category: CategoryData.cupertino,
          asset: const AssetImage(
            'assets/images/material.png',
          ),
          data: [],
        ),
        _DesktopCategoryItem(
          category: CategoryData.other,
          asset: const AssetImage('assets/images/material.png'),
          data: [],
        ),
      ];
      return Scaffold(
          body: ListView(
        key: const ValueKey('HomeListView'),
        padding: EdgeInsetsDirectional.only(top: firstHeaderDesktopTopPadding),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalDesktopPadding,
            ),
            child: Header(
                color: Theme.of(context).colorScheme.primary,
                text: locale(context).head),
          ),
          SizedBox(
              height: _carouselHeightMin,
              child: _DesktopCarousel(children: carouselCards)),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalDesktopPadding,
            ),
            child: Header(
                color: Theme.of(context).colorScheme.primary,
                text: locale(context).head),
          ),
          Container(
            height: 585,
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalDesktopPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: spaceBetween(28, desktopCategoryItems),
            ),
          ),
          Padding(
              padding: const EdgeInsetsDirectional.only(
                start: _horizontalDesktopPadding,
                bottom: 81,
                end: _horizontalDesktopPadding,
                top: 109,
              ),
              child: Row(children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.end,
                    children: const [
                      SettingsAbout(),
                      SettingsFeedback(),
                      SettingsAttribution(),
                    ],
                  ),
                ),
              ]))
        ],
      ));
    } else {
      return Scaffold(
        body: _AnimatedHomePage(
          restorationId: 'animated_page',
          carouselCards: carouselCards,
        ),
      );
    }
  }

  List<Widget> spaceBetween(double paddingBetween, List<Widget> children) {
    return [
      for (int index = 0; index < children.length; index++) ...[
        Flexible(
          child: children[index],
        ),
        if (index < children.length - 1) SizedBox(width: paddingBetween),
      ],
    ];
  }
}

class _DesktopCategoryItem extends StatelessWidget {
  const _DesktopCategoryItem({
    required this.category,
    required this.asset,
    required this.data,
  });
  final CategoryData category;
  final ImageProvider asset;
  final List<Data> data;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: Semantics(
        container: true,
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: Column(
            children: [
              _DesktopCategoryHeader(
                category: category,
                asset: asset,
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: colorScheme.background,
              ),
              Flexible(
                child: ListView.builder(
                  // Makes integration tests possible.
                  key: ValueKey('${category.name}DemoList'),
                  itemBuilder: (context, index) =>
                      CategoryItem(data: data[index]),
                  itemCount: data.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopCategoryHeader extends StatelessWidget {
  const _DesktopCategoryHeader({
    required this.category,
    required this.asset,
  });
  final CategoryData category;
  final ImageProvider asset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      // Makes integration tests possible.
      key: ValueKey('${category.name}CategoryHeader'),
      color: colorScheme.onBackground,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FadeInImagePlaceholder(
              image: asset,
              placeholder: const SizedBox(
                height: 64,
                width: 64,
              ),
              width: 64,
              height: 64,
              excludeFromSemantics: true,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Semantics(
                header: true,
                child: Text(
                  category.displayTitle(locale(context)),
                  style: Theme.of(context).textTheme.headline5?.apply(
                        color: colorScheme.onSurface,
                      ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedHomePage extends StatefulWidget {
  const _AnimatedHomePage(
      {Key? key, required this.restorationId, required this.carouselCards})
      : super(key: key);

  final String restorationId;
  final List<Widget> carouselCards;
  @override
  _AnimatedHomePageState createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<_AnimatedHomePage>
    with RestorationMixin, SingleTickerProviderStateMixin {
  final RestorableBool _isMaterialListExpanded = RestorableBool(false);
  final RestorableBool _isCupertinoListExpanded = RestorableBool(false);
  final RestorableBool _isOtherListExpanded = RestorableBool(false);
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isMaterialListExpanded.dispose();
    _isCupertinoListExpanded.dispose();
    _isOtherListExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(
          // Makes integration tests possible.
          key: const ValueKey('HomeListView'),
          restorationId: 'home_list_view',
          children: [
            const SizedBox(height: 8),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Header(
                  color: Theme.of(context).colorScheme.primary,
                  text: locale(context).head),
            ),
            Carousel(
              animationController: _animationController,
              restorationId: 'home_carousel',
              children: widget.carouselCards,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Header(
                  color: Theme.of(context).colorScheme.primary,
                  text: locale(context).head),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.00,
              controller: _animationController,
              child: CategoryListItem(
                  key: const PageStorageKey<CategoryData>(
                    CategoryData.material,
                  ),
                  restorationId: 'home_material_category_list',
                  category: CategoryData.material,
                  imageString: 'assets/images/material.png',
                  data: [],
                  initiallyExpanded: _isMaterialListExpanded.value,
                  onTap: (shouldOpenList) {
                    _isMaterialListExpanded.value = shouldOpenList;
                  }),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.05,
              controller: _animationController,
              child: CategoryListItem(
                  key: const PageStorageKey<CategoryData>(
                    CategoryData.cupertino,
                  ),
                  restorationId: 'home_cupertino_category_list',
                  category: CategoryData.cupertino,
                  imageString: 'assets/images/material.png',
                  data: [],
                  initiallyExpanded: _isCupertinoListExpanded.value,
                  onTap: (shouldOpenList) {
                    _isCupertinoListExpanded.value = shouldOpenList;
                  }),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.10,
              controller: _animationController,
              child: CategoryListItem(
                  key: const PageStorageKey<CategoryData>(
                    CategoryData.other,
                  ),
                  restorationId: 'home_other_category_list',
                  category: CategoryData.other,
                  imageString: 'assets/images/material.png',
                  data: [],
                  initiallyExpanded: _isOtherListExpanded.value,
                  onTap: (shouldOpenList) {
                    _isOtherListExpanded.value = shouldOpenList;
                  }),
            ),
          ]),
      Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > 200) {
              ToggleSplashNotification().dispatch(context);
            }
          },
          child: SafeArea(
            child: Container(
              height: 40,
              // If we don't set the color, gestures are not detected.
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isMaterialListExpanded, 'material_list');
    registerForRestoration(_isCupertinoListExpanded, 'cupertino_list');
    registerForRestoration(_isOtherListExpanded, 'other_list');
  }
}

/// Animates the category item to stagger in. The [_AnimatedCategoryItem.startDelayFraction]
/// gives a delay in the unit of a fraction of the whole animation duration,
/// which is defined in [_AnimatedHomePageState].
class _AnimatedCategoryItem extends StatelessWidget {
  _AnimatedCategoryItem({
    Key? key,
    required double startDelayFraction,
    required this.controller,
    required this.child,
  })  : topPaddingAnimation = Tween(
          begin: 60.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000 + startDelayFraction,
              0.400 + startDelayFraction,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Widget child;
  final AnimationController controller;
  final Animation<double> topPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.only(top: topPaddingAnimation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.color, required this.text})
      : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isDisplayDesktop(context) ? 63 : 15,
        bottom: isDisplayDesktop(context) ? 21 : 11,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4!.apply(
              color: color,
              fontSizeDelta:
                  isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
            ),
      ),
    );
  }
}

/// This creates a horizontally scrolling [ListView] of items.
///
/// This class uses a [ListView] with a custom [ScrollPhysics] to enable
/// snapping behavior. A [PageView] was considered but does not allow for
/// multiple pages visible without centering the first page.
class _DesktopCarousel extends StatefulWidget {
  const _DesktopCarousel({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _DesktopCarouselState createState() => _DesktopCarouselState();
}

class _DesktopCarouselState extends State<_DesktopCarousel> {
  static const cardPadding = 15.0;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _builder(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: cardPadding,
      ),
      child: widget.children[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    var showPreviousButton = false;
    var showNextButton = true;
    // Only check this after the _controller has been attached to the ListView.
    if (_controller.hasClients) {
      showPreviousButton = _controller.offset > 0;
      showNextButton =
          _controller.offset < _controller.position.maxScrollExtent;
    }
    final totalWidth = MediaQuery.of(context).size.width -
        (_horizontalDesktopPadding - cardPadding) * 2;
    final itemWidth = totalWidth / _desktopCardsPerPage;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _horizontalDesktopPadding - cardPadding,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const _SnappingScrollPhysics(),
            controller: _controller,
            itemExtent: itemWidth,
            itemCount: widget.children.length,
            itemBuilder: (context, index) => _builder(index),
          ),
        ),
        if (showPreviousButton)
          _DesktopPageButton(
            onTap: () {
              _controller.animateTo(
                _controller.offset - itemWidth,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        if (showNextButton)
          _DesktopPageButton(
            isEnd: true,
            onTap: () {
              _controller.animateTo(
                _controller.offset + itemWidth,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
      ],
    );
  }
}

/// Scrolling physics that snaps to the new item in the [_DesktopCarousel].
class _SnappingScrollPhysics extends ScrollPhysics {
  const _SnappingScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  _SnappingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnappingScrollPhysics(parent: buildParent(ancestor));
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    final itemWidth = position.viewportDimension / _desktopCardsPerPage;
    var item = position.pixels / itemWidth;
    if (velocity < -tolerance.velocity) {
      item -= 0.5;
    } else if (velocity > tolerance.velocity) {
      item += 0.5;
    }
    return math.min(
      item.roundToDouble() * itemWidth,
      position.maxScrollExtent,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = this.tolerance;
    final target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => true;
}

class _DesktopPageButton extends StatelessWidget {
  const _DesktopPageButton({
    Key? key,
    this.isEnd = false,
    required this.onTap,
  }) : super(key: key);

  final bool isEnd;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    const buttonSize = 58.0;
    const padding = _horizontalDesktopPadding - buttonSize / 2;
    return ExcludeSemantics(
      child: Align(
        alignment: isEnd
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          margin: EdgeInsetsDirectional.only(
            start: isEnd ? 0 : padding,
            end: isEnd ? padding : 0,
          ),
          child: Tooltip(
            message: isEnd
                ? MaterialLocalizations.of(context).nextPageTooltip
                : MaterialLocalizations.of(context).previousPageTooltip,
            child: Material(
              color: Colors.black.withOpacity(0.5),
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  isEnd ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.animationController,
    required this.restorationId,
    required this.children,
  }) : super(key: key);

  final AnimationController animationController;
  final String restorationId;
  final List<Widget> children;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with RestorationMixin, SingleTickerProviderStateMixin {
  late PageController _controller;

  final RestorableInt _currentPage = RestorableInt(0);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentPage, 'carousel_page');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // The viewPortFraction is calculated as the width of the device minus the
    // padding.
    final width = MediaQuery.of(context).size.width;
    const padding = (_horizontalPadding * 2) - (_carouselItemMargin * 2);
    _controller = PageController(
      initialPage: _currentPage.value,
      viewportFraction: (width - padding) / width,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  Widget builder(int index) {
    final carouselCard = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value;
        if (_controller.position.haveDimensions) {
          value = (_controller.page! - index);
        } else {
          // If haveDimensions is false, use _currentPage to calculate value.
          value = (_currentPage.value - index).toDouble();
        }
        // We want the peeking cards to be 160 in height and 0.38 helps
        // achieve that.
        value = (1 - (value.abs() * .38)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Center(
          child: Transform(
            transform: Matrix4.diagonal3Values(1.0, value, 1.0),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: widget.children[index],
    );

    // We only want the second card to be animated.
    if (index == 1) {
      return _AnimatedCarouselCard(
        controller: widget.animationController,
        child: carouselCard,
      );
    } else {
      return carouselCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedCarousel(
      controller: widget.animationController,
      child: PageView.builder(
        // Makes integration tests possible.
        key: const ValueKey('studyDemoList'),
        onPageChanged: (value) {
          setState(() {
            _currentPage.value = value;
          });
        },
        controller: _controller,
        itemCount: widget.children.length,
        itemBuilder: (context, index) => builder(index),
        allowImplicitScrolling: true,
      ),
    );
  }
}

class _AnimatedCarouselCard extends StatelessWidget {
  _AnimatedCarouselCard({
    Key? key,
    required this.child,
    required this.controller,
  })  : startPaddingAnimation = Tween(
          begin: _horizontalPadding,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.900,
              1.000,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: startPaddingAnimation.value,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

/// Animates the carousel to come in from the right.
class _AnimatedCarousel extends StatelessWidget {
  _AnimatedCarousel({
    Key? key,
    required this.child,
    required this.controller,
  })  : startPositionAnimation = Tween(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.200,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPositionAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          SizedBox(height: _carouselHeightMin),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return PositionedDirectional(
                start: constraints.maxWidth * startPositionAnimation.value,
                child: child!,
              );
            },
            child: SizedBox(
              height: _carouselHeightMin,
              width: constraints.maxWidth,
              child: child,
            ),
          ),
        ],
      );
    });
  }
}
