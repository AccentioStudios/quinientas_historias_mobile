import '../../helpers/http_helper.dart';
import '../environments/platform_environments.dart';
import '../http/http_imp.dart';

export '../../../core/extensions/http_extension.dart' show HttpExtension;

mixin ApiService {
  HttpHelper get appApi => HttpImp(
        hostUrl: PlatformEnvironment.apiHostUrl,
      );
}
