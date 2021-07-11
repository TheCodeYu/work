import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:work/components/icp.dart';
import 'package:work/utils/adaptive.dart';

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
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    if (isDisplayDesktop(context)) {
      const sortKeyName = 'Overview';
      return SingleChildScrollView(
        restorationId: 'overview_scroll_view',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: Semantics(
                  sortKey: const OrdinalSortKey(1, name: sortKeyName),
                  child: const _OverviewGrid(spacing: 24),
                ),
              ),
              const SizedBox(width: 24,height: 1000,),
               Container(width: 24,height: 1000,child: Text('11111'),color: Colors.white,),
              Flexible(
                flex: 3,
                child: SizedBox(
                  width: 400,
                  child: Semantics(
                    sortKey: const OrdinalSortKey(2, name: sortKeyName),

                  ),
                ),
              ),

            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        restorationId: 'overview_scroll_view',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [

              Container(width: 24,height: 1000,child: Text('11111'),color: Colors.white,),
              const _OverviewGrid(spacing: 12),
            ],
          ),
        ),
      );
    }
  }
}


class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid({Key? key, required this.spacing}) : super(key: key);

  final double spacing;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {

      // Only display multiple columns when the constraints allow it and we
      // have a regular text scale factor.
      const minWidthForTwoColumns = 600;
      final hasMultipleColumns = isDisplayDesktop(context) &&
          constraints.maxWidth > minWidthForTwoColumns;

      final boxWidth = hasMultipleColumns
          ? constraints.maxWidth / 2 - spacing / 2
          : double.infinity;

      return Wrap(
        runSpacing: spacing,
        children: [
          SizedBox(
            width: boxWidth,

          ),
          if (hasMultipleColumns) SizedBox(width: spacing),
          SizedBox(
            width: boxWidth,

          ),

        ],
      );
    });
  }
}
