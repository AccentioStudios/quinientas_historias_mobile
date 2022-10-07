import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quinientas_historias/core/failures/failures.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/mixins/form_validation.dart';
import '../../../../core/mixins/stream_disposable.dart';
import '../../data/models/register_request_model.dart';
import '../../data/useCases/user_management_use_cases.dart';

part 'user_management_cubit.freezed.dart';
part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState>
    with StreamDisposable, FormValidation {
  UserManagementCubit({
    required this.userManagementUseCases,
  }) : super(const UserManagementState());

  final UserManagementUseCases userManagementUseCases;

  void initNewUser(String email, String invitationCode) {
    emit(state.copyWith(
        registerUser:
            RegisterUserRequest(email: email, invitationCode: invitationCode)));
  }

  void saveNewUserChanges({
    String? password,
    String? passwordConfirmation,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) {
    if (state.registerUser != null) {
      final RegisterUserRequest user = RegisterUserRequest(
        email: state.registerUser!.email,
        invitationCode: state.registerUser!.invitationCode,
        firstName: firstName ?? state.registerUser!.firstName,
        lastName: lastName ?? state.registerUser!.lastName,
        avatarUrl: avatarUrl ?? state.registerUser!.avatarUrl,
        password: password ?? state.registerUser!.password,
        passwordConfirmation:
            passwordConfirmation ?? state.registerUser!.passwordConfirmation,
      );
      emit(state.copyWith(registerUser: user));
    }
  }

  Future<TaskSnapshot?> uploadPhoto(UserManagementState state) async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    UploadTask uploadTask;
    XFile? image;
    const Uuid uuid = Uuid();

    //Check Permissions
    await Permission.photos.request();
    final PermissionStatus permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final uuidString = uuid.v1();

      //Select Image
      image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(state.copyWith(uploadingAvatar: true));
        final ref = firebaseStorage.ref().child(
            'usersAvatars/avatar-${state.registerUser?.email}-$uuidString');

        if (kIsWeb) {
          uploadTask = ref.putData(await image.readAsBytes());
        } else {
          uploadTask = ref.putFile(io.File(image.path));
        }
        final snapshot = await uploadTask.whenComplete(() {});

        emit(state.copyWith(uploadingAvatar: false));

        return Future.value(snapshot);
      }
      emit(state.copyWith(uploadingAvatar: false));
    }

    return Future.value(null);
  }

  void registerNewUser(
      {required Function onSuccess, required Function onError}) async {
    validateForm();
    if (state.error != null) {
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    // await Future.delayed(const Duration(seconds: 3));

    // onSuccess();
    // emit(state.copyWith(isLoading: false, error: null));

    if (state.registerUser != null) {
      userManagementUseCases.registerUser(state.registerUser!).listen((event) {
        onSuccess();
        emit(state.copyWith(isLoading: false, error: null));
      }, onError: (error) {
        onError(error);
        emit(state.copyWith(isLoading: false, error: error));
      }).subscribe(this);
    }
  }

  void validateForm() {
    bool valid = true;

    if (state.registerUser == null) {
      valid = false;
    }
    if (state.registerUser?.email == null) {
      valid = false;
    }

    if (state.registerUser?.firstName == null) {
      valid = false;
    }

    if (state.registerUser?.lastName == null) {
      valid = false;
    }

    if (state.registerUser?.invitationCode == null) {
      valid = false;
    }
    if (state.registerUser?.password == null) {
      valid = false;
    }
    if (state.registerUser?.passwordConfirmation == null) {
      valid = false;
    }

    if (!valid) {
      emit(state.copyWith(
          error: HttpFailure(
              statusCode: StatusCodes.badRequest,
              error: FailureType.fieldsError)));
      return;
    }
    emit(state.copyWith(error: null));
  }
}
