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
    ///使用MultiBlocProvider包裹
    /////Bloc提供器
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => GlobalBloc(storage))],
        child: child);
  }
}
