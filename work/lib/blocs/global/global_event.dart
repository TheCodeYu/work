part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class EventInitApp extends GlobalEvent {
  const EventInitApp();
  @override
  List<Object> get props => [];
}

class EventIntoHome extends GlobalEvent {
  const EventIntoHome();
  @override
  List<Object> get props => [];
}

class EventExitApp extends GlobalEvent {
  final BuildContext context;
  const EventExitApp(this.context);
  @override
  List<Object> get props => [context];
}
