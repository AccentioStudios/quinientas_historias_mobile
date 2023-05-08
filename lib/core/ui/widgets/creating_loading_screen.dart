import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../utils/constants.dart';

class CreatingLoadingScreen extends StatelessWidget {
  const CreatingLoadingScreen({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 300,
            height: 300,
            child: RiveAnimation.asset(
              'assets/images/circular-satelital-loading-animation.riv',
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: Constants.space21),
          Text(
            message ?? 'Cargando...',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: Constants.space21),
        ],
      ),
    );
  }
}
