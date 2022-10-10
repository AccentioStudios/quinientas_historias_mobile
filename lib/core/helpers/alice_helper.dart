// Singleton
import 'package:alice_lightweight/alice.dart';

class AliceHelper {
  static final AliceHelper _instance = AliceHelper._internal();
  factory AliceHelper() {
    return _instance;
  }
  AliceHelper._internal();

  static final Alice instance = Alice();
}
