import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    const TextStyle userNameProfileTextStyle =
        (TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

    return Container(
      child: Column(
        children: <Widget>[
          AppBar(
            elevation: 0,
            centerTitle: false,
            toolbarHeight: 64,
            actions: [
              IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Editar perfil"),
              )
            ],
          ),
          _UserProfile(
              userNameProfileTextStyle: userNameProfileTextStyle, user: user)
        ],
      ),
    );
    /*return ListView(
      children: <Widget>[
        AppBar(
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 64,
          actions: [
            IconButton(
              iconSize: 24,
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Editar perfil"),
            )
          ],
        ),
        _UserProfile(
            userNameProfileTextStyle: userNameProfileTextStyle, user: user)
      ],
    );*/
  }
}

class _UserProfile extends StatelessWidget {
  const _UserProfile(
      {Key? key, required this.userNameProfileTextStyle, required this.user})
      : super(key: key);

  final TextStyle userNameProfileTextStyle;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(Constants.space18),
          child: UserAvatar(
            user: user!,
            width: 140,
            height: 140,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(user!.firstName ?? '', style: userNameProfileTextStyle),
          ],
        ),
      ],
    );
  }
}
