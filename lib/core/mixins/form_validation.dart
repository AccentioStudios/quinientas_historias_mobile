mixin FormValidation {
  bool validateEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    // Verifica email que tenga formato xxx@xxx, con guiones,
    // guiones bajos y el signo más (+) en el nombre de usuario.
    // Además, la parte del dominio después de la arroba (@) solo permite letras y números,
    // sin incluir guiones bajos o la tilde.
    final regexExpresion = RegExp(
        r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false,
        multiLine: false);

    return regexExpresion.hasMatch(email);
  }

  bool validateUserSearchEmail(String texto) {
    if (texto.isEmpty) {
      return false;
    }
    // regex que verifique un texto que solo pueda tener numeros, letras, puntos, guiones, guiones bajos, signo más (+) y arroba (@)
    // Este no verifica formato.
    final regexExpresion =
        RegExp(r'^[\w.+@-]+$', caseSensitive: false, multiLine: false);

    return texto.length > 3 && regexExpresion.hasMatch(texto);
  }

  bool isNumeric(String s) {
    final result = double.tryParse(s) != null;
    return result;
  }
}
