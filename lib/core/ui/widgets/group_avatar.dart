import 'package:flutter/material.dart';

enum GroupAvatarType { team, school }

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({
    Key? key,
    this.avatarUrl,
    this.width = 42,
    this.height = 42,
    required this.type,
  }) : super(key: key);

  final String? avatarUrl;
  final double width;
  final double height;
  final GroupAvatarType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(
        minHeight: 12,
        minWidth: 12,
        maxWidth: 140,
        maxHeight: 140,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.onBackground),
        image: avatarUrl != null && avatarUrl != ""
            ? DecorationImage(
                image: Image.network(
                  avatarUrl!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ).image,
                fit: BoxFit.contain,
              )
            : DecorationImage(
                image: type == GroupAvatarType.school
                    ? const AssetImage(
                        'assets/images/avatar-school-placeholder-image.jpg')
                    : const AssetImage(
                        'assets/images/avatar-team-placeholder-image.jpg'),
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
