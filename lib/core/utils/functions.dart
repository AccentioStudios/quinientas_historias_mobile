import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../data/entities/user_entity.dart';
import '../theme/theme.dart';

String getRoleText(Role role) {
  switch (role) {
    case Role.admin:
      return 'Admin';
    case Role.captain:
      return 'Capitán';
    case Role.public:
      return 'Publico';
    case Role.reader:
      return 'Lector';
    case Role.prof:
      return 'Profesor';
    case Role.jury:
      return 'Jurado';
    case Role.editor:
      return 'Editor';
  }
}

Future<CroppedFile?> pickPhoto({required WebUiSettings webUiSettings}) async {
  final imagePicker = ImagePicker();
  XFile? image;

  image = await imagePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    final CroppedFile? croppedPhoto =
        await cropPhoto(image, webUiSettings: webUiSettings);
    return Future.value(croppedPhoto);
  }

  return Future.value(null);
}

Future<CroppedFile?> cropPhoto(XFile image,
    {required WebUiSettings webUiSettings}) async {
  final CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    cropStyle: CropStyle.circle,
    compressQuality: 60,
    compressFormat: ImageCompressFormat.jpg,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ],
    uiSettings: [
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
      webUiSettings,
    ],
  );
  return Future.value(croppedFile);
}
