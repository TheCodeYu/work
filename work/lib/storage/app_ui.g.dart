// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_ui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUI _$AppUIFromJson(Map<String, dynamic> json) {
  return AppUI()
    ..sw = (json['sw'] as num).toDouble()
    ..sh = (json['sh'] as num).toDouble()
    ..aw = (json['aw'] as num).toDouble()
    ..ah = (json['ah'] as num).toDouble()
    ..lastExit = DateTime.parse(json['lastExit'] as String);
}

Map<String, dynamic> _$AppUIToJson(AppUI instance) => <String, dynamic>{
      'sw': instance.sw,
      'sh': instance.sh,
      'aw': instance.aw,
      'ah': instance.ah,
      'lastExit': instance.lastExit.toIso8601String(),
    };
