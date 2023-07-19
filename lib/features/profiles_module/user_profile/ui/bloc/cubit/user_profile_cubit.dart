import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/data/dto/auth_dto.dart';
import '../../../../../../core/data/dto/user_profile_dto.dart';
import '../../../../../../core/failures/failures.dart';
import '../../../../../../core/integrations/secure_storage_service.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../../quiz/domain/entities/quiz_items.entity.dart';
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

  getUserData(
      {required Function(UserProfileDto) onSuccess,
      required Function onError}) {
    emit(state.copyWith(isLoading: true, httpFailure: null));

    userProfileUseCases.getUserProfile(userId).listen((userProfile) async {
      // Verify if userId is the same as session user
      emit(state.copyWith(user: userProfile));

      final JwtPayload? userInfo =
          await GetIt.I<SecureStorageService>().getSessionData();

      if (userInfo?.id == userProfile.id) {
        emit(state.copyWith(isMyProfile: true));
      }
      onSuccess(userProfile);
      emit(state.copyWith(isLoading: false));
    }, onError: (httpFailure) {
      emit(state.copyWith(httpFailure: httpFailure, isLoading: false));
      onError(httpFailure);
    }).subscribe(this);
  }

  updatePendingQuizItemsToReview(List<QuizItem> update) {
    emit(state.copyWith(
        user: state.user?.copyWith(pendingQuizItemsToReview: update)));
  }
}
