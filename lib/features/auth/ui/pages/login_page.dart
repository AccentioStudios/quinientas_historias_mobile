import 'dart:async';

import 'package:alice_lightweight/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../../core/integrations/firebase_messaging_service.dart';
import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/auto_router.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/link_button.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget with ErrorHandling {
  const LoginPage({
    super.key,
    this.autoNavigateToShell = true,
    this.byPassFirstScreen = false,
    this.onResult,
  });

  final bool autoNavigateToShell;
  final bool byPassFirstScreen;
  final Function(dynamic)? onResult;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final FirebaseMessagingService firebaseMessagingService;

  bool btnLoginLoading = false;

  @override
  void initState() {
    super.initState();
    firebaseMessagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    if (widget.byPassFirstScreen == true) {
      _loginFlow(context, firebaseMessagingService, context.read<AuthCubit>());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.loading || widget.byPassFirstScreen == true
              ? Scaffold(
                  body: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: RiveAnimation.asset(
                                'assets/images/geometric-loading-animation.riv'),
                          ),
                          SizedBox(height: Constants.space21),
                          Text(
                            'Entrando a 500Historias',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: Constants.space21),
                        ],
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    leading: Container(),
                    actions: [
                      // TextButton.icon(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.help_outline_outlined),
                      //     label: const Text('Ayuda')),
                      if (PlatformEnvironment.env != 'prod')
                        TextButton.icon(
                            onPressed: () {
                              GetIt.I<Alice>().showInspector();
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Abrir Alice Inspector ')),
                    ],
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: IntrinsicHeight(
                        child: PaddingColumn(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space18),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 137,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            const SizedBox(height: Constants.space41),
                            const Text('¡Bienvenido!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: Constants.space21),
                            const Text(
                                'Inicia sesión para poder interactuar con la comunidad de 500Historias',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: SvgPicture.asset(
                                        'assets/images/login-image.svg'),
                                  ),
                                  BigButton(
                                    isLoading: btnLoginLoading,
                                    onPressed: () {
                                      setState(() {
                                        btnLoginLoading = true;
                                      });
                                      _loginFlow(
                                              context,
                                              firebaseMessagingService,
                                              authCubit)
                                          .then((logged) {
                                        setState(() {
                                          btnLoginLoading = false;
                                        });
                                      }, onError: (error) {
                                        setState(() {
                                          btnLoginLoading = false;
                                        });
                                      });
                                    },
                                    text: 'Entrar a 500Historias',
                                  ),
                                  const SizedBox(height: Constants.space21),
                                  LinkButton(
                                      onTap: () {
                                        AutoRouter.of(context)
                                            .push(const TournamentRoute());
                                      },
                                      text: 'Entrar sin usuario'),
                                  const SizedBox(height: Constants.space21),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future<bool> _loginFlow(
      BuildContext context,
      FirebaseMessagingService firebaseMessagingService,
      AuthCubit authCubit) async {
    final completer = Completer<bool>();

    String? firebaseToken;

    if (!kIsWeb) {
      firebaseToken = await firebaseMessagingService.getDeviceFirebaseToken();
    }

    authCubit.wpOpenIdLogin(onSuccess: (accessToken) {
      authCubit.loginIntoTelle(
          firebaseToken: firebaseToken,
          accessToken: accessToken,
          onError: (error) => widget.handleError(context, error, onTap: () {
                if (widget.onResult != null) widget.onResult!(false);
                Navigator.of(context).pop(false);
                completer.complete(false);
              }),
          onSuccess: () {
            if (widget.onResult != null) widget.onResult!(true);
            Navigator.of(context).pop(true);

            completer.complete(true);

            if (widget.autoNavigateToShell) {
              context.router.navigate(const ShellRoute());
              return;
            }
          });
    }, onError: (error) {
      if (error is PlatformException) {
        if (error.code == 'CANCELLED') {
          Fluttertoast.showToast(msg: "Inicio de sesión cancelado");
        }
      } else {
        Fluttertoast.showToast(msg: "Error al iniciar sesión");
      }
      completer.completeError(false);
    });

    return completer.future;
  }
}
