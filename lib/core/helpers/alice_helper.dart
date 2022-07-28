import 'package:alice/alice.dart';

// Singleton
class AliceHelper extends Alice {
  static final AliceHelper _instance = AliceHelper._internal();
  factory AliceHelper() {
    return _instance;
  }
  AliceHelper._internal();

  static final Alice instance = Alice(showNotification: true);
}
