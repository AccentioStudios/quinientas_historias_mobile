import 'package:flutter/material.dart';

import '../../../../core/data/entities/user_entity.dart';

class InvitesPage extends StatelessWidget {
  const InvitesPage({Key? key, required this.typeUserToInvite})
      : super(key: key);

  final UserType typeUserToInvite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitar a un lector'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
