import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:quinientas_historias/core/helpers/shared_preferences_helper.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/data/dto/user_profile_dto.dart';
import '../../../../core/data/entities/invites_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/failures/status_codes.dart';
import '../../../../core/mixins/form_validation.dart';
import '../../../../core/mixins/stream_disposable.dart';
import '../../data/models/accept_invite.dto.dart';
import '../../data/useCases/user_management_use_cases.dart';

part 'user_management_cubit.freezed.dart';
part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState>
    with StreamDisposable, FormValidation {
  UserManagementCubit({
    required this.userManagementUseCases,
  }) : super(const UserManagementState());

  final UserManagementUseCases userManagementUseCases;

  void initNewUser(String email, Invite invite) {
    emit(state.copyWith(
        invite: invite,
        user: UserDto(
            email: email,
            firstName: '',
            lastName: '',
            password: '',
            username: '')));
  }

  void loadUser(UserProfileDto user) {
    emit(state.copyWith(
      user: UserDto(
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName!,
        avatarUrl: user.avatarUrl!,
        teamId: user.team?.id,
        schoolId: user.school?.id,
      ),
    ));
  }

  void saveChanges({
    String? password,
    String? passwordConfirmation,
    String? firstName,
    String? username,
    String? lastName,
    String? avatarUrl,
  }) {
    if (state.user != null) {
      emit(state.copyWith(
          user: state.user!.copyWith(
        username: username ?? state.user!.username,
        firstName: firstName ?? state.user!.firstName,
        lastName: lastName ?? state.user!.lastName,
        email: state.user!.email,
        avatarUrl: avatarUrl ?? state.user!.avatarUrl,
        password: password ?? state.user!.password,
        passwordConfirmation:
            passwordConfirmation ?? state.user!.passwordConfirmation,
      )));
    }
  }

  Future<TaskSnapshot?> uploadPhoto(CroppedFile? image) async {
    final firebaseStorage = FirebaseStorage.instance;
    UploadTask uploadTask;
    const Uuid uuid = Uuid();

    final uuidString = uuid.v1();

    if (image != null) {
      final ref = firebaseStorage
          .ref()
          .child('usersAvatars/avatar-${state.user?.email}-$uuidString');

      if (kIsWeb) {
        uploadTask = ref.putData(await image.readAsBytes());
      } else {
        uploadTask = ref.putFile(io.File(image.path));
      }
      final snapshot = (await uploadTask);

      return Future.value(snapshot);
    }

    return Future.value(null);
  }

  void handleSaveAvatarMemory(CroppedFile? image) async {
    if (image != null) {
      emit(state.copyWith(avatarMemory: image));
      return;
    }
    emit(state.copyWith(avatarMemory: null));
  }

  Future<bool> handleSaveAvatarUrl() async {
    if (state.avatarMemory != null) {
      TaskSnapshot? snapshot = await uploadPhoto(state.avatarMemory);
      if (snapshot != null) {
        final avatarUrl = await snapshot.ref.getDownloadURL();
        saveChanges(avatarUrl: avatarUrl);
        return true;
      }
      Fluttertoast.showToast(
          msg: 'Error al subir el avatar. Intenta nuevamente');
      return false;
    }
    return true;
  }

  void acceptInvite(Invite invite,
      {required Function onSuccess, required Function onError}) async {
    // We need to validate if the invite is for a captain, if it is, we need to verify the tournamentId
    if (invite.invitedRole == Role.captain) {
      if (invite.tournamentId != null) {
      } else {
        // If the invite is for a captain and the tournamentId is null, we need to throw an error
        final error =
            Exception('Error. Invitación de capitán no tiene asociado torneo');
        Fluttertoast.showToast(
            msg: 'Error. Invitación de capitán no tiene asociado torneo');
        onError(error);
      }
    }
    emit(state.copyWith(isLoading: true, error: null));
    userManagementUseCases.acceptInvite(AcceptInviteDto(invite: invite)).listen(
        (event) {
      onSuccess();
      // If the invite is for a captain, we need to save the tournamentId in the shared preferences
      if (invite.invitedRole == Role.captain) {
        SharedPreferencesHelper.instance
            .setInt('captainTournamentId', invite.tournamentId!);
      }
      emit(state.copyWith(isLoading: false, error: null));
    }, onError: (error) {
      onError(error);
      emit(state.copyWith(isLoading: false, error: error));
    }).subscribe(this);
  }

  void registerNewUser(String? firebaseToken,
      {required Function onSuccess, required Function onError}) async {
    validateRegisterForm();
    if (state.error != null) {
      return;
    }
    emit(state.copyWith(registeringUser: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.user != null) {
        userManagementUseCases
            .acceptInvite(AcceptInviteDto(
                invite: state.invite!,
                user: state.user!,
                firebaseToken: firebaseToken))
            .listen((event) {
          onSuccess();
          emit(state.copyWith(registeringUser: false, error: null));
        }, onError: (error) {
          onError(error);
          emit(state.copyWith(registeringUser: false, error: error));
        }).subscribe(this);
      }
    }
  }

  void editUser(
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.user != null) {
        userManagementUseCases.editUser(state.user!).listen((event) {
          onSuccess();
          emit(state.copyWith(isLoading: false, error: null));
        }, onError: (error) {
          onError(error);
          emit(state.copyWith(isLoading: false, error: error));
        }).subscribe(this);
      }
    }
  }

  void validateRegisterForm() {
    bool valid = true;

    if (state.user == null) {
      valid = false;
    }
    if (state.user?.email == null) {
      valid = false;
    }

    if (state.user?.username == null) {
      valid = false;
    }

    if (state.user?.firstName == null) {
      valid = false;
    }

    if (state.user?.lastName == null) {
      valid = false;
    }

    if (state.invite?.code == null) {
      valid = false;
    }
    if (state.user?.password == null) {
      valid = false;
    }
    if (state.user?.passwordConfirmation == null) {
      valid = false;
    }

    if (!valid) {
      emit(state.copyWith(
          error: HttpFailure(
              statusCode: StatusCodes.badRequest,
              message: FailureTypes.fieldsError)));
      return;
    }
    emit(state.copyWith(error: null));
  }
}
