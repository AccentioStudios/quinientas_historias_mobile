import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:quinientas_historias/features/user_managment/data/useCases/group_management_use_cases.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/failures/status_codes.dart';
import '../../../../core/mixins/form_validation.dart';
import '../../../../core/mixins/stream_disposable.dart';
import '../../data/models/group_management_request_model.dart';

part 'group_management_state.dart';
part 'group_management_cubit.freezed.dart';

class GroupManagementCubit extends Cubit<GroupManagementState>
    with StreamDisposable, FormValidation {
  GroupManagementCubit({
    required this.groupManagementUseCases,
  }) : super(const GroupManagementState());

  final GroupManagementUseCases groupManagementUseCases;

  void initNewTeam(
    String schoolName,
  ) {
    emit(state.copyWith(
        groupManagementRequest: GroupManagementRequest(name: schoolName)));
  }

  void loadTeam(Team team) {
    emit(state.copyWith(
      groupManagementRequest: GroupManagementRequest(
        id: team.id,
        name: team.name,
        avatarUrl: team.avatarUrl!,
      ),
    ));
  }

  void loadSchool(School school) {
    emit(state.copyWith(
      groupManagementRequest: GroupManagementRequest(
        id: school.id,
        name: school.name,
        avatarUrl: school.avatarUrl!,
      ),
    ));
  }

  void saveGroupManagementRequestChanges({
    String? name,
    String? avatarUrl,
  }) {
    if (state.groupManagementRequest != null) {
      final GroupManagementRequest user = GroupManagementRequest(
        id: state.groupManagementRequest!.id,
        avatarUrl: avatarUrl ?? state.groupManagementRequest!.avatarUrl,
        name: name ?? state.groupManagementRequest!.name,
      );
      emit(state.copyWith(groupManagementRequest: user));
    }
  }

  void registerNewTeam(
      {required Function(Team) onSuccess, required Function onError}) async {
    validateRegisterForm();
    if (state.error != null) {
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.groupManagementRequest != null) {
        groupManagementUseCases
            .registerTeam(state.groupManagementRequest!)
            .listen((team) {
          onSuccess(team);
          emit(state.copyWith(isLoading: false, error: null));
        }, onError: (error) {
          onError(error);
          emit(state.copyWith(isLoading: false, error: error));
        }).subscribe(this);
      }
    }
  }

  void editTeam(
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.groupManagementRequest != null) {
        groupManagementUseCases.editTeam(state.groupManagementRequest!).listen(
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

  void editSchool(
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(isLoading: true, error: null));
    if (await handleSaveAvatarUrl()) {
      if (state.groupManagementRequest != null) {
        groupManagementUseCases
            .editSchool(state.groupManagementRequest!)
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

  void validateRegisterForm() {
    bool valid = true;

    if (state.groupManagementRequest == null) {
      valid = false;
    }
    if (state.groupManagementRequest?.name == null) {
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

  Future<bool> handleSaveAvatarUrl() async {
    if (state.avatarMemory != null) {
      TaskSnapshot? snapshot = await uploadPhoto(state.avatarMemory);
      if (snapshot != null) {
        final avatarUrl = await snapshot.ref.getDownloadURL();
        saveGroupManagementRequestChanges(avatarUrl: avatarUrl);
        return true;
      }
      Fluttertoast.showToast(
          msg: 'Error al subir el avatar. Intenta nuevamente');
      return false;
    }
    return true;
  }

  Future<TaskSnapshot?> uploadPhoto(CroppedFile? image) async {
    final firebaseStorage = FirebaseStorage.instance;
    UploadTask uploadTask;
    const Uuid uuid = Uuid();

    final uuidString = uuid.v1();

    if (image != null) {
      final ref = firebaseStorage.ref().child(
          'teamsAvatars/avatar-${state.groupManagementRequest?.name}-$uuidString');

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
}
