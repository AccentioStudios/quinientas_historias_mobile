import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserProfileHeader extends StatelessWidget with SheetMessages {
  const UserProfileHeader({
    super.key,
    required this.state,
  });

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            height: 55 + MediaQuery.of(context).padding.top,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                  right: Constants.space18),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.space8, vertical: Constants.space4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: const Text('Nivel {nivel}')),
            ),
          ),
          PaddingColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 8),
              UserAvatar(width: 82, height: 82, user: state.user?.toEntity()),
              const SizedBox(height: Constants.space18),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.user!.firstName} ${state.user!.lastName}',
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.aboveBaseline,
                      baseline: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () {
                          showMessage(
                            context,
                            content:
                                'Este usuario es capitán de ${state.user?.team?.name}',
                            title: 'Capitán de equipo',
                            iconSvgPath: 'assets/icons/star-icon.svg',
                            height: 278,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space4),
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child:
                                SvgPicture.asset('assets/icons/star-icon.svg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Constants.space12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    child: SvgPicture.asset(
                        'assets/icons/bookmark-outline-icon.svg'),
                  ),
                  const SizedBox(width: Constants.space8),
                  Text(
                    '${state.user?.favoriteStories.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Favoritos',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 24,
                    child: SvgPicture.asset(
                        'assets/icons/book-open-outline-icon.svg'),
                  ),
                  const SizedBox(width: Constants.space8),
                  Text(
                    '${state.user?.userReadsCount}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Lecturas Totales',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
