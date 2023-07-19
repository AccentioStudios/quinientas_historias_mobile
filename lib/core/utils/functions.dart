import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quinientas_historias/core/integrations/platform_environments.dart';
import 'package:share_plus/share_plus.dart';

import '../data/entities/story_entity.dart';
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

Future<Uri> generateDynamicLinkForStory(Story story) async {
  var weblink = 'https://telle.500historias.com/';
  var uriPrefix = 'https://quinientas.page.link';
  if (PlatformEnvironment.env == 'prod') {}
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse('$weblink${story.id}'),
    uriPrefix: uriPrefix,
    androidParameters: AndroidParameters(
      packageName: "com.accentiostudios.quinientas",
      fallbackUrl: Uri.parse('$weblink/${story.id}'),
    ),
    iosParameters: IOSParameters(
      bundleId: "com.accentiostudios.quinientas",
      fallbackUrl: Uri.parse('$weblink/${story.id}'),
    ),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  return dynamicLink.shortUrl;
}

shareLink(String link, String title) {
  Share.share('Mira esta historia: $link', subject: title);
}
