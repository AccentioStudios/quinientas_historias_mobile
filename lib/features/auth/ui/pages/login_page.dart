import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/link_button.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/integrations/alice_service.dart';
import '../../../../core/integrations/firebase_messaging_service.dart';
import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../bloc/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget with ErrorHandling {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final FirebaseMessagingService firebaseMessagingService;

  @override
  void initState() {
    super.initState();
    firebaseMessagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: Container(),
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.help_outline_outlined),
                label: const Text('Ayuda')),
            if (PlatformEnvironment.env != 'prod')
              TextButton.icon(
                  onPressed: () {
                    AliceService.instance.showInspector();
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Abrir Alice Inspector ')),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.loading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 50,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : IntrinsicHeight(
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
                                    onPressed: () {
                                      _loginAndNavigateToShell(context,
                                          firebaseMessagingService, authCubit);
                                    },
                                    text: 'Entrar a 500Historias',
                                  ),
                                  const SizedBox(height: Constants.space21),
                                  LinkButton(
                                      onTap: () {},
                                      text: 'Tengo una invitacion'),
                                  const SizedBox(height: Constants.space21),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _loginAndNavigateToShell(
      BuildContext context,
      FirebaseMessagingService firebaseMessagingService,
      AuthCubit authCubit) async {
    String? firebaseToken;

    if (!kIsWeb) {
      firebaseToken = await firebaseMessagingService.getDeviceFirebaseToken();
    }
    //  else {
    //   firebaseToken = await firebaseMessagingService.getDeviceFirebaseToken(
    //       vapidKey:
    //           '');
    // }

    authCubit.login(
        firebaseToken: firebaseToken,
        onSuccess: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(Routes.homeNavigator);
        },
        onError: (HttpFailure error) {
          widget.handleError(context, error);
        });
  }
}
