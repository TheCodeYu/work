import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///   name:data
///   author:Administrator
///   data:2021/7/21 0021
///   description:
enum CategoryData {
  study,
  material,
  cupertino,
  other,
}

extension CategoryDataExtension on CategoryData {
  String get name => describeEnum(this);

  String displayTitle(AppLocalizations localizations) {
    switch (this) {
      case CategoryData.material:
        return 'MATERIAL';
      case CategoryData.cupertino:
        return 'CUPERTINO';
      case CategoryData.study:
        return "Study";
      default:
        return 'localizations';
    }
  }
}

class Data {
  const Data({
    required this.title,
    required this.category,
    required this.subtitle,
    // This parameter is required for studies.
    this.studyId,
    // Parameters below are required for non-study demos.
    this.slug,
    this.icon,
  });

  final String title;
  final CategoryData category;
  final String subtitle;
  final String? studyId;
  final String? slug;
  final IconData? icon;

  String get describe => '${slug ?? studyId}@${category.name}';
}
