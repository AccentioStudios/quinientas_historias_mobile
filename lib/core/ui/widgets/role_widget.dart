import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/entities/user_entity.dart';
import '../../integrations/secure_storage_service.dart';

class RoleWidget extends StatelessWidget {
  /// Shows the child widget when the logged user has any of the [roles].
  ///
  /// The [child] argument must not be null.
  /// The [roles] argument must not be null.
  const RoleWidget(
      {super.key,
      required this.child,
      required this.roles,
      this.forPublic = false});
  final Widget child;
  final List<Role> roles;
  final bool forPublic;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<SecureStorageService>().getSessionData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // build child if user is same as one of the roles in the list
        if (snapshot.hasData && roles.contains(snapshot.data?.role)) {
          return child;
        }
        if (snapshot.connectionState == ConnectionState.done &&
            forPublic &&
            snapshot.data?.role == null) {
          return child;
        }
        // return empty if is loading or user is not in the list
        return const SizedBox.shrink();
      },
    );
  }

  Future<bool> verifyRole() async {
    final user = await GetIt.I<SecureStorageService>().getSessionData();
    return roles.contains(user?.role);
  }
}
