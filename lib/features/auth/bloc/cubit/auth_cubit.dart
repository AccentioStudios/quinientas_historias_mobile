import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/features/auth/data/useCases/auth_usecases.dart';

import '../../../../core/mixins/stream_disposable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> with StreamDisposable {
  AuthCubit({
    required this.authUseCases,
  }) : super(AuthState.initial());

  final AuthUseCases authUseCases;

  void login() {
    authUseCases.login().listen((event) {}).subscribe(this);
  }
}
