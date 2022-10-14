import 'package:flutter/material.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Todavia no hay suficientes participantes :('));
  }
}

class PageErrorIndicator extends StatelessWidget {
  const PageErrorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Hubo un problema al intentar buscar los participantes o todavía no existe equipo :(',
      textAlign: TextAlign.center,
    ));
  }
}
