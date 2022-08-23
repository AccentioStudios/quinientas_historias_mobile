import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/user_profile_usecases.dart';

part 'user_profile_state.dart';
part 'user_profile_cubit.freezed.dart';

class UserProfileCubit extends Cubit<UserProfileState> with StreamDisposable {
  UserProfileCubit({
    this.userId,
    required this.userProfileUseCases,
  }) : super(const UserProfileState());

  final UserProfileUseCases userProfileUseCases;

  final int? userId;
  // if not userId is provided then load user session profile

  getUserData({required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    userProfileUseCases.getUserProfile(userId).listen((userProfile) {
      emit(state.copyWith(user: userProfile));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
