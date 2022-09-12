import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/user_profile_usecases.dart';

part 'user_profile_cubit.freezed.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> with StreamDisposable {
  UserProfileCubit({
    this.userId,
    required this.userProfileUseCases,
  }) : super(const UserProfileState());

  final UserProfileUseCases userProfileUseCases;

  final int? userId;

  getUserData({required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    userProfileUseCases.getUserProfile(userId).listen((userProfile) async {
      // Verify if userId is the same as session user
      emit(state.copyWith(user: userProfile));

      final JWTTokenModel? sessionData =
          await SecureStorageHelper.getSessionData();
      if (sessionData?.user.id == userProfile.id) {
        emit(state.copyWith(isMyProfile: true));
      }
      onSuccess();
      emit(state.copyWith(isLoading: false));
    }, onError: (error) {
      emit(state.copyWith(error: error, isLoading: false));
      onError(error);
    }).subscribe(this);
  }
}
