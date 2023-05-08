import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoRouteBlocProviderValue<T extends StateStreamableSource<Object?>>
    extends StatelessWidget implements AutoRouteWrapper {
  const AutoRouteBlocProviderValue(
      {super.key, required this.child, required this.bloc});
  final Widget child;
  final T bloc;
  @override
  Widget build(BuildContext context) => child;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<T>.value(value: bloc, child: child);
  }
}
