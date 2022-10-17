import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/models/invites_request_model.dart';
import '../bloc/cubit/send_invites_cubit.dart';

class InvitesSendInvitationPage extends StatefulWidget with ErrorHandling {
  const InvitesSendInvitationPage(
      {Key? key, required this.typeUserToInvite, this.teamId, this.schoolId})
      : super(key: key);
  final UserType typeUserToInvite;
  final int? teamId;
  final int? schoolId;
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
          floatingActionButton: !state.formValidationError &&
                  emailController.text.isNotEmpty &&
                  currentPage == 0
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    submit();
                  },
                  child: SizedBox(
                      child: SvgPicture.asset(
                    'assets/icons/arrow-forward.svg',
                    color: Theme.of(context).colorScheme.onPrimary,
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
                onChanged: (text) {
                  context.read<SendInvitesCubit>().validateForm(text);
                },
              ),
              _SendEmailPageTwo(
                state: state,
                email: emailController.text,
                pageController: pageController,
                emailController: emailController,
              ),
            ],
          ),
        );
      },
    );
  }

  submit() {
    if (emailFocus.hasFocus) {
      emailFocus.unfocus();
    }
    context.read<SendInvitesCubit>().sendInvite(
        InvitesRequest(
          email: emailController.text,
          type: widget.typeUserToInvite,
          teamId: widget.teamId,
          schoolId: widget.schoolId,
        ),
        onSuccess: () {}, onError: (HttpFailure error) {
      if (error.error == FailureType.userAlreadyInvited) {
        setState(() {
          emailFieldErrorMessage = error.message;
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
                    : 'Otro amigo más será parte del torneo!',
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
    required this.onChanged,
    this.errorText,
  }) : super(key: key);
  final TextEditingController emailController;
  final FocusNode emailFocus;
  final void Function(String)? onChanged;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space30),
      children: [
        const Headline(
          marginTop: 0,
          marginBottom: Constants.space30,
          label: 'Cuál es el e-mail del\namigo que quieres invitar?',
          fontSize: 24,
        ),
        ThemedTextFormField(
          errorText: errorText,
          autofocus: true,
          focusNode: emailFocus,
          controller: emailController,
          hintText: 'Email',
          prefixIconSvgPath: 'assets/icons/mail-outline-icon.svg',
          keyboardType: TextInputType.emailAddress,
          onChanged: onChanged,
        )
      ],
    ));
  }
}
