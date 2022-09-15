import '../helpers/http_helper.dart';
import 'platform_environments.dart';
import 'http_imp.dart';

export '../extensions/http_extension.dart' show HttpExtension;

mixin ApiService {
  HttpHelper get appApi => HttpImp(
        hostUrl: PlatformEnvironment.apiHostUrl,
      );
}
