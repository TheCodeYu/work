import 'package:work/blocs/detail/detail_bloc.dart';
import 'package:work/storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global/global_bloc.dart';

AppStorage storage = AppStorage();

class BlocWrapper extends StatelessWidget {
  final Widget child;

  BlocWrapper(this.child);

  @override
  Widget build(BuildContext context) {
    ///使用MultiBlocProvider包裹 注册Bloc
    /////Bloc提供器
    return MultiBlocProvider(providers: [
      BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc(storage)..add(EventInitApp())),
      BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(storage)..add(DetailInitApp()))
    ], child: child);
  }
}
