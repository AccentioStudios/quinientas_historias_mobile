import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/functions.dart';
import '../../../data/models/invites_request_model.dart';
import '../bloc/cubit/send_invites_cubit.dart';

class InvitesSendInvitationPage extends StatefulWidget with ErrorHandling {
  const InvitesSendInvitationPage({
    Key? key,
    required this.typeUserToInvite,
    this.team,
    this.schoolId,
    this.tournamentId,
  }) : super(key: key);
  final Role typeUserToInvite;
  final Team? team;
  final int? schoolId;
  final int? tournamentId;
  @override
  State<InvitesSendInvitationPage> createState() =>
      _InvitesSendInvitationPageState();
}

class _InvitesSendInvitationPageState extends State<InvitesSendInvitationPage> {
  late TextEditingController emailController;
  late PageController pageController;
  late FocusNode emailFocus;
  String? emailFieldErrorMessage;
  int currentPage = 0;
  String selectedEmail = '';

  @override
  void initState() {
    emailController = TextEditingController();
    pageController = PageController(initialPage: currentPage);
    emailFocus = FocusNode();
    emailFocus.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendInvitesCubit, SendInvitesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
          floatingActionButton: state.isSearchingUsers && currentPage == 0
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  child: Center(
                      child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )),
                )
              : null,
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              _EnterEmailPageOne(
                errorText: emailFieldErrorMessage,
                emailController: emailController,
                emailFocus: emailFocus,
                role: widget.typeUserToInvite,
                selectedUser: (user) =>
                    submit(email: user.email, invitedId: user.id),
                selectedEmail: (email) {
                  if (state.emailIsValid) {
                    submit(email: email);
                  }
                },
              ),
              _SendEmailPageTwo(
                state: state,
                email: selectedEmail,
                pageController: pageController,
                emailController: emailController,
              ),
            ],
          ),
        );
      },
    );
  }

  submit({required String email, int? invitedId}) {
    selectedEmail = email;
    if (currentPage == 0) {
      if (emailFocus.hasFocus) {
        emailFocus.unfocus();
      }
      context.read<SendInvitesCubit>().sendInvite(
          CreateInviteDto(
            email: email,
            invitedId: invitedId,
            type: widget.typeUserToInvite,
            teamId: widget.team?.id,
            schoolId: widget.schoolId,
            tournamentId: widget.tournamentId,
          ),
          onSuccess: () {}, onError: (HttpFailure error) {
        if (error.message == FailureTypes.userAlreadyInvited) {
          setState(() {
            emailFieldErrorMessage = 'El usuario ya pertenece a otro equipo';
          });
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic);
          return;
        }
        widget.handleError(context, error, onTap: () {
          Navigator.of(context).pop(true);
          Navigator.of(context).pop(true);
        });
      });

      pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic);
    }
  }
}

class _SendEmailPageTwo extends StatelessWidget {
  const _SendEmailPageTwo({
    Key? key,
    required this.state,
    required this.email,
    required this.pageController,
    required this.emailController,
  }) : super(key: key);

  final SendInvitesState state;
  final String email;
  final PageController pageController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: state.sendingInvite ? 0 : 1.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: PaddingColumn(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.space16),
                children: [
                  SizedBox(
                    height: 55,
                    child: BigButton(
                      elevation: 5,
                      onPressed: () {
                        emailController.clear();
                        pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic);
                      },
                      text: 'Invitar a alguien más',
                    ),
                  ),
                  const SizedBox(height: Constants.space16),
                  SizedBox(
                    height: 55,
                    child: BigButton(
                      elevation: 5,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      text: 'Volver',
                      filled: false,
                    ),
                  ),
                  const SizedBox(height: Constants.space12),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: PaddingColumn(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space30),
            children: [
              AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  child: SizedBox(
                      height: state.sendingInvite
                          ? MediaQuery.of(context).size.height / 2 - 200
                          : 0)),
              AnimatedContainer(
                width: state.sendingInvite ? 120 : 100,
                height: state.sendingInvite ? 120 : 100,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  duration: const Duration(milliseconds: 500),
                  child: getIcon(state),
                ),
              ),
              const SizedBox(height: Constants.space30),
              Text(
                state.sendingInvite
                    ? 'Enviando tu increíble\ninvitación'
                    : 'Otro más será parte del torneo!',
                textAlign:
                    state.sendingInvite ? TextAlign.center : TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 0.4),
              ),
              if (!state.sendingInvite)
                const SizedBox(height: Constants.space16),
              if (!state.sendingInvite)
                Text(
                  'Enviamos su invitación para\n$email. Solo falta esperar que acepte y formará parte del torneo también.',
                  style: const TextStyle(fontSize: 16, letterSpacing: 0.3),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getIcon(SendInvitesState state) {
    if (state.sendingInvite) {
      return const RiveAnimation.asset('assets/images/sending-animation.riv');
    }
    return const SizedBox(
      width: 100,
      height: 100,
      child: RiveAnimation.asset('assets/images/success-check-animation.riv'),
    );
  }
}

class _EnterEmailPageOne extends StatelessWidget {
  const _EnterEmailPageOne({
    Key? key,
    required this.emailFocus,
    required this.emailController,
    required this.selectedUser,
    required this.selectedEmail,
    required this.role,
    this.errorText,
  }) : super(key: key);
  final TextEditingController emailController;
  final FocusNode emailFocus;
  final void Function(User) selectedUser;
  final void Function(String) selectedEmail;
  final String? errorText;
  final Role role;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: PaddingColumn(
          mainAxisSize: MainAxisSize.min,
          padding: const EdgeInsets.symmetric(horizontal: Constants.space21),
          children: [
            const Headline(
              marginTop: Constants.space12,
              marginBottom: Constants.space30,
              label: 'Cuál es el e-mail de la\npersona que quieres invitar?',
              fontSize: 24,
            ),
            ThemedTextFormField(
              style: const TextStyle(fontSize: 15),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              borderRadius: BorderRadius.circular(10),
              errorText: errorText,
              autofocus: true,
              focusNode: emailFocus,
              controller: emailController,
              hintText: 'Email',
              prefixIconSvgPath: 'assets/icons/mail-outline-icon.svg',
              keyboardType: TextInputType.emailAddress,
              suffix: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.space8),
                child: Transform.translate(
                  offset: const Offset(0, -6),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(6)),
                      child: Transform.translate(
                        offset: const Offset(0, 6),
                        child: Text(
                          getRoleText(role),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onTertiary),
                        ),
                      )),
                ),
              ),
            ),
            const SizedBox(height: Constants.space21),
            SearchUserList(
              emailController: emailController,
              selectedUser: (user) => selectedUser(user),
              selectedEmail: (email) => selectedEmail(email),
            ),
          ],
        ));
  }
}

class SearchUserList extends StatefulWidget {
  const SearchUserList(
      {super.key,
      required this.selectedUser,
      required this.selectedEmail,
      required this.emailController,
      this.forceUserExists = false});
  final void Function(User) selectedUser;
  final void Function(String) selectedEmail;
  final TextEditingController emailController;
  final bool forceUserExists;

  @override
  State<SearchUserList> createState() => _SearchUserListState();
}

class _SearchUserListState extends State<SearchUserList> {
  StreamController<String> searchStreamController = StreamController<String>();

  @override
  void initState() {
    widget.emailController.addListener(triggerSearch);
    searchStreamController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((email) {
      searchUsers(email);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    searchStreamController.close();
    super.dispose();
  }

  void triggerSearch() {
    final email = widget.emailController.text;
    searchStreamController.add(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendInvitesCubit, SendInvitesState>(
      builder: (context, state) {
        return Column(
          children: [
            buildSendToNewUser(state),
            buildUserDontExists(state) ??
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.searchUsersList.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: Constants.space21),
                      child: UserListTile(
                        user: state.searchUsersList![index],
                        onTap: (tapped) {
                          widget.selectedUser(state.searchUsersList![index]);
                        },
                        trailingWidget: SizedBox(
                          height: 35,
                          child: SvgPicture.asset(
                              'assets/icons/send-outline-icon.svg'),
                        ),
                      ),
                    );
                  },
                ),
          ],
        );
      },
    );
  }

  Widget? buildUserDontExists(SendInvitesState state) {
    return widget.forceUserExists &&
            state.searchUsersList.length == 0 &&
            !state.isSearchingUsers &&
            widget.emailController.text.isNotEmpty
        ? const _EmptyStateUserList()
        : null;
  }

  Widget buildSendToNewUser(SendInvitesState state) {
    return !widget.forceUserExists && widget.emailController.text.isNotEmpty
        ? Column(
            children: [
              UserListTile(
                email: widget.emailController.text,
                isValid: state.emailIsValid,
                onTap: (tapped) {
                  widget.selectedEmail(tapped);
                },
                trailingWidget: SizedBox(
                  height: 35,
                  child: SvgPicture.asset('assets/icons/send-outline-icon.svg'),
                ),
              ),
              if (state.searchUsersList.length > 0)
                const Divider(height: Constants.space41)
            ],
          )
        : const SizedBox.shrink();
  }

  searchUsers(String email) {
    context.read<SendInvitesCubit>().searchUsers(email);
  }
}

class _EmptyStateUserList extends StatelessWidget {
  const _EmptyStateUserList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 24,
            child: SvgPicture.asset('assets/icons/face-sad-outline-icon.svg'),
          ),
          const SizedBox(height: Constants.space8),
          const Text(
            'El usuario no existe :(',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Constants.space8),
          Text(
            'Intenta escribir el email nuevamente o pídele a la persona que se registre antes en 500Historias.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          )
        ],
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile(
      {super.key,
      this.user,
      this.email,
      this.isValid,
      required this.onTap,
      this.trailingWidget});

  final User? user;
  final String? email;
  final bool? isValid;
  final Function(String) onTap;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      onTap: () {
        if (user != null) {
          onTap(user!.email);
        } else {
          if (email != null) onTap(email!);
        }
      },
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space16, vertical: Constants.space12),
      backgroundColor: brandBlue.withOpacity(0.08),
      border: isValid != null
          ? isValid!
              ? Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary
                      .withOpacity(0.08)) // is valid
              : Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? errorDarkColor.withOpacity(0.2)
                      : errorColor.withOpacity(0.08)) // is not valid
          : Border.all(color: Colors.white.withOpacity(0.08)), // we dont know,
      child: Column(
        children: [
          email != null
              ? Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 35),
                    Expanded(
                      child: AutoSizeText.rich(
                        TextSpan(
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                              text: '$email ',
                            ),
                          ],
                        ),
                        maxLines: 1,
                        maxFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: Constants.space8),
                    isValid != null
                        ? isValid!
                            ? SizedBox(
                                height: 35,
                                child: SvgPicture.asset(
                                    'assets/icons/send-outline-icon.svg'),
                              )
                            : const SizedBox.shrink()
                        : const SizedBox.shrink(),
                  ],
                )
              : Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Constants.space16),
                      child: SizedBox(
                          width: 35,
                          child: UserAvatar(
                            user: user,
                          )),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${user?.firstName} ${user?.lastName} ',
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  maxFontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: Constants.space8),
                              trailingWidget ?? const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
