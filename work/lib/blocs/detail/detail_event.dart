part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailInitApp extends DetailEvent {
  const DetailInitApp();
  @override
  List<Object> get props => [];
}

class DetailUpdateApp extends DetailEvent {
  const DetailUpdateApp(this.settings);
  final dynamic settings;
  @override
  List<Object> get props => [settings];
}
