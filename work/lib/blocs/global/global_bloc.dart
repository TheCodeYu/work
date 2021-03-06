import 'package:flutter/foundation.dart';
import 'package:work/storage/app_storage.dart';
import 'package:work/utils/adaptive.dart';
import 'package:work/utils/log_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final AppStorage storage;

  GlobalBloc(this.storage) : super(GlobalState());

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is EventInitApp) {
      yield await storage.initApp();

      ///状态值在yield后更新  print(state.toString());
    }
    if (event is EventIntoHome) {
      var s = storage.intoHome();

      yield state.copyWith(
        showBackGround: s.showBackGround,
        itemStyleIndex: s.itemStyleIndex,
        codeStyleIndex: s.codeStyleIndex,
      );
    }
    if (event is EventupdateSetting) {
      if (event.setting is Locale) {
        yield state.copyWith(locale: event.setting);
      }
    }
    if (event is EventExitApp) {
      storage.exitApp(event.context);
      yield state;
    }
    LogUtil.info(
        this.runtimeType.toString(), '${event.toString()} ${state.toString()}');
  }
}
