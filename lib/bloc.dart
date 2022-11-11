import 'dart:async';

abstract class BlocEvent {}

abstract class BlocState {}

abstract class Bloc<E extends BlocEvent, S extends BlocState> {
  final _action$ = StreamController<E>();
  final _state$ = StreamController<S>();
  final _subscription = <StreamSubscription>[];

  late S _state;

  S get state => _state;

  Stream<S> get state$ => _state$.stream;

  Bloc(S initialState) {
    emit(initialState);
    _subscription.add(_action$.stream.listen((event) {
      onEventChange(event);
    }));
  }

  void dispose() {
    for (var element in _subscription) {
      element.cancel();
    }
  }

  void emit(S state) {
    _state = state;
    _state$.add(state);
  }

  void onEventChange(E event);
}
