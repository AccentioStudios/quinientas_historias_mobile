import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../widgets/hero_header_widget.dart';
import '../widgets/home_app_bar.dart';

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
        return Scaffold(
          body: state.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
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
                        HomeAppBar(
                            user: state.user,
                            userNameTextStyle: userNameTextStyle,
                            userTypeTextStyle: userTypeTextStyle),
                        const PaddingColumn(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.space18),
                          children: [
                            HeroHeader(),
                          ],
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
