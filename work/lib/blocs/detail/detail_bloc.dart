import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/constants/sp.dart';
import 'package:work/storage/app_storage.dart';
import 'package:work/utils/log_utils.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.storage) : super(DetailState());
  final AppStorage storage;

  SharedPreferences get sp => storage.sp;

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailInitApp) {
      //  await sp
      //   ..setInt(SP.fontFamily, familyIndex); //固化数据
      // yield state.copyWith(fontFamily: event.family);

      yield state.copyWith(token: storage.getToken());
    }

    if (event is DetailUpdateApp) {
      await sp.setString(SP.token, event.settings);
      yield state.copyWith(token: event.settings);
    }
    LogUtil.info(
        this.runtimeType.toString(), '${event.toString()} ${state.toString()}');
  }
}
