import 'package:work/storage/app_storage.dart';
import 'package:work/storage/app_ui.dart';
import 'package:work/utils/log_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final AppStorage storage;

  GlobalBloc(this.storage) : super(GlobalState());

  Future<SharedPreferences> get sp => storage.sp;

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
          appUI: s.appUI);
    }
    if (event is EventExitApp) {
      storage.exitApp(event.context);
      yield state;
    }
    LogUtil.info(
        this.runtimeType.toString(), '${event.toString()} ${state.toString()}');
  }
}
