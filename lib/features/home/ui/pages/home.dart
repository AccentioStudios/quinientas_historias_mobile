import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/failures/failures.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../auth/data/entities/user_entity.dart';
import '../../bloc/cubit/home_cubit.dart';

class HomePage extends StatefulWidget with ErrorHandling {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<HomeCubit>(context)
        .loadUserData(onError: (error) => widget.handleError(context, error));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle userNameTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const TextStyle userTypeTextStyle = TextStyle(fontSize: 14);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: ListView(
                  padding: const EdgeInsets.only(top: 0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 290 + MediaQuery.of(context).padding.top,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Column(children: [
                        Container(
                          color: Colors.black12,
                          width: double.infinity,
                          height: 84,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space18,
                              vertical: Constants.space21),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _Username(
                                userNameTextStyle: userNameTextStyle,
                                userTypeTextStyle: userTypeTextStyle,
                                user: state.user,
                              ),
                              _UserStreak(),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class _UserStreak extends StatelessWidget {
  const _UserStreak({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/flame-icon.svg',
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const SizedBox(width: Constants.space4),
        Text(
          '0',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
    required this.userNameTextStyle,
    required this.userTypeTextStyle,
    required this.user,
  }) : super(key: key);

  final TextStyle userNameTextStyle;
  final TextStyle userTypeTextStyle;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CircleAvatar(),
        const SizedBox(width: Constants.space18),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(user?.firstName ?? '', style: userNameTextStyle),
            Text(user?.type.name ?? '', style: userTypeTextStyle),
          ],
        ),
      ],
    );
  }

  String formatUserType(UserType userType) {
    switch (userType) {
      case UserType.reader:
        return 'Lector';
      case UserType.prof:
        return 'Profesor';
      case UserType.writer:
        return 'Escritor';
      case UserType.unknown:
        return '';
    }
  }
}
