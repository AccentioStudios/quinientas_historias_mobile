import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/buttom_bar.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionBtnDocked(
        onPressed: () {
          // _navigateToDailyChallengePage(context, state, cubit);
        },
      ),
      bottomNavigationBar: const AppButtonBar(
        activeOption: ActiveOptionAppButtonBar.home,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
