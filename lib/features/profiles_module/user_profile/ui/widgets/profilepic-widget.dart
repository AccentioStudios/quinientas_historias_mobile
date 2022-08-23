import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/bloc/cubit/user_profile_cubit.dart';

import '../../../../../core/ui/widgets/buttom_bar.dart';

class ProfilePicWidget extends StatelessWidget {
  final String imagePath;

  const ProfilePicWidget({Key? key, required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Stack(
      children: [
        buildImage(),
      ],
    ));
  }

  Widget buildImage() {
    const image = AssetImage('assets/images/login-image.svg');
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}
