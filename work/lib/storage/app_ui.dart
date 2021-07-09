import 'package:json_annotation/json_annotation.dart';

///flutter packages pub run build_runner build
part 'app_ui.g.dart';

@JsonSerializable()
class AppUI {
  double sw = 600;

  double sh = 450;

  double aw = 600;

  double ah = 450;

  DateTime lastExit = DateTime.now();
  AppUI();
  AppUI.copy(this.sw, this.sh);
  @override
  String toString() {
    return 'AppUI{size:$sw $sh,alignment:$aw $ah,DateTime:$lastExit}';
  }

  factory AppUI.fromJson(Map<String, dynamic> json) => _$AppUIFromJson(json);

  Map<String, dynamic> toJson() => _$AppUIToJson(this);
}
