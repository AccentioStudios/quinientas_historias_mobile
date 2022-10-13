import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/theme.dart';

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
