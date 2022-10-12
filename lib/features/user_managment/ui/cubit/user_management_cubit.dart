import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quinientas_historias/core/failures/failures.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';
import 'package:quinientas_historias/core/theme/theme.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/mixins/form_validation.dart';
import '../../../../core/mixins/stream_disposable.dart';
import '../../data/models/user_management_request_model.dart';
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
        userManagementRequest: UserManagementRequest(
            email: email, invitationCode: invitationCode)));
  }

  void loadUser(User user) {
    emit(state.copyWith(
      userManagementRequest: UserManagementRequest(
        id: user.id,
        email: user.email!,
        firstName: user.firstName!,
        lastName: user.lastName!,
        avatarUrl: user.avatarUrl!,
      ),
    ));
  }

  void saveUserManagementRequestChanges({
    String? password,
    String? passwordConfirmation,
    String? firstName,
    String? lastName,
    String? avatarUrl,
  }) {
    if (state.userManagementRequest != null) {
      final UserManagementRequest user = UserManagementRequest(
        id: state.userManagementRequest!.id,
        email: state.userManagementRequest!.email,
        invitationCode: state.userManagementRequest!.invitationCode,
        firstName: firstName ?? state.userManagementRequest!.firstName,
        lastName: lastName ?? state.userManagementRequest!.lastName,
        avatarUrl: avatarUrl ?? state.userManagementRequest!.avatarUrl,
        password: password ?? state.userManagementRequest!.password,
        passwordConfirmation: passwordConfirmation ??
            state.userManagementRequest!.passwordConfirmation,
      );
      emit(state.copyWith(userManagementRequest: user));
    }
  }

  Future<CroppedFile?> pickPhoto() async {
    final imagePicker = ImagePicker();
    XFile? image;

    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final CroppedFile? croppedPhoto = await cropPhoto(image);
      return Future.value(croppedPhoto);
    }

    return Future.value(null);
  }

  Future<CroppedFile?> cropPhoto(XFile image) async {
    final CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: image.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ], uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cortar imagen',
        toolbarColor: ThemeClass.darkTheme.colorScheme.primaryContainer,
        toolbarWidgetColor: ThemeClass.darkTheme.colorScheme.onPrimaryContainer,
        backgroundColor: ThemeClass.darkTheme.colorScheme.background,
        activeControlsWidgetColor: ThemeClass.lightTheme.colorScheme.primary,
      ),
      IOSUiSettings(
        title: 'Cortar imagen',
      ),
    ]);
    return Future.value(croppedFile);
  }

  Future<TaskSnapshot?> uploadPhoto(CroppedFile? image) async {
    final firebaseStorage = FirebaseStorage.instance;
    UploadTask uploadTask;
    const Uuid uuid = Uuid();

    final uuidString = uuid.v1();

    if (image != null) {
      final ref = firebaseStorage.ref().child(
          'usersAvatars/avatar-${state.userManagementRequest?.email}-$uuidString');

      if (kIsWeb) {
        uploadTask = ref.putData(await image.readAsBytes());
      } else {
        uploadTask = ref.putFile(io.File(image.path));
      }
      final snapshot = await uploadTask.whenComplete(() {});

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
        saveUserManagementRequestChanges(avatarUrl: avatarUrl);
        return true;
      }
      Fluttertoast.showToast(
          msg: 'Error al subir el avatar. Intenta nuevamente');
      return false;
    }
    return true;
  }

  void registerNewUser(
      {required Function onSuccess, required Function onError}) async {
    validateRegisterForm();
    if (state.error != null) {
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.userManagementRequest != null) {
        userManagementUseCases
            .registerUser(state.userManagementRequest!)
            .listen((event) {
          onSuccess();
          emit(state.copyWith(isLoading: false, error: null));
        }, onError: (error) {
          onError(error);
          emit(state.copyWith(isLoading: false, error: error));
        }).subscribe(this);
      }
    }
  }

  void editUser(
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.userManagementRequest != null) {
        userManagementUseCases.editUser(state.userManagementRequest!).listen(
            (event) {
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

    if (state.userManagementRequest == null) {
      valid = false;
    }
    if (state.userManagementRequest?.email == null) {
      valid = false;
    }

    if (state.userManagementRequest?.firstName == null) {
      valid = false;
    }

    if (state.userManagementRequest?.lastName == null) {
      valid = false;
    }

    if (state.userManagementRequest?.invitationCode == null) {
      valid = false;
    }
    if (state.userManagementRequest?.password == null) {
      valid = false;
    }
    if (state.userManagementRequest?.passwordConfirmation == null) {
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
