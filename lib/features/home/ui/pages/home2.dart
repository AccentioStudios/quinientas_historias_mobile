import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/home_cubit.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getDashboard(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
            body:
                // state.loading && state.dashboard?.user == null
                false
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          // await getDashboard(context);
                        },
                        child: Center(child: Text('Home 2 ')),
                      ));
      },
    );
  }

  getDashboard(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).getDashboard(
        onSuccess: (dashboard) async {}, onError: (error) async {});
  }
}
