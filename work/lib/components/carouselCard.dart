import 'package:flutter/material.dart';
import 'package:work/components/image_placeholder.dart';
import 'package:work/utils/adaptive.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.asset,
      required this.assetColor})
      : super(key: key);

  final String title;
  final ImageProvider asset;
  final String subtitle;
  final Color assetColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(title),
      margin: EdgeInsets.all(isDisplayDesktop(context) ? 0 : 8.0),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImagePlaceholder(
                image: asset,
                placeholder: Container(
                  color: assetColor,
                ),
                child: Ink.image(
                  image: asset,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      subtitle,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
