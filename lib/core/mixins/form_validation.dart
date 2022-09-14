mixin FormValidation {
  bool validateEmail(String s) {
    final regex = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(s);
  }

  bool isNumeric(String s) {
    final result = double.tryParse(s) != null;
    return result;
  }
}
