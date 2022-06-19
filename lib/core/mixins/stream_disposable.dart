import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

mixin StreamDisposable<State> on BlocBase<State> {
  final List<StreamSubscription> _subscriptions = [];

  @override
  Future<void> close() {
    _unsubscribeAll();
    return super.close();
  }

  void _unsubscribeAll() {
    for (final StreamSubscription i in _subscriptions) {
      i.cancel();
    }
    _subscriptions.clear();
  }

  void _subscribe(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}

extension StreamsSubs<T> on StreamSubscription<T> {
  StreamSubscription<T> subscribe(StreamDisposable disposable) {
    disposable._subscribe(this);
    return this;
  }
}
