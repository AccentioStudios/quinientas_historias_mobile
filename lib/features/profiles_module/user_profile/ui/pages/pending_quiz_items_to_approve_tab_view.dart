import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/features/quiz/data/repositories/quiz_item_repository.dart';
import 'package:quinientas_historias/features/quiz/domain/bloc/cubit/quiz_cubit.dart';

import '../../../../../core/data/dto/user_profile_dto.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../quiz/domain/entities/quiz_items.entity.dart';

class PendingQuizItemsToApproveTabView extends StatefulWidget {
  const PendingQuizItemsToApproveTabView(
      {super.key,
      required this.user,
      required this.quizItems,
      required this.updateQuizAnswers});

  final UserProfileDto user;
  final List<QuizItem> quizItems;
  final Function(List<QuizItem>) updateQuizAnswers;

  @override
  State<PendingQuizItemsToApproveTabView> createState() =>
      _PendingQuizItemsToApproveTabViewState();
}

class _PendingQuizItemsToApproveTabViewState
    extends State<PendingQuizItemsToApproveTabView> {
  late List<QuizItem> quizItemsNew;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  initState() {
    quizItemsNew = widget.quizItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (context) =>
          QuizCubit(quizItems: [], repository: QuizRepository()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
        child: quizItemsNew.isNotEmpty
            ? AnimatedList(
                key: _listKey,
                initialItemCount: quizItemsNew.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: Constants.space30),
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Constants.space18),
                    child: _buildItem(quizItemsNew[index], index, animation),
                  );
                },
              )
            : const PendingQuizEmptyState(),
      ),
    );
  }

  submit(bool approved, int index, QuizCubit cubit) {
    cubit.approveOrDisapproveQuizItem(approved, quizItemsNew[index].id!).then(
        (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(approved == true
            ? 'Pregunta aprobada exitosamente.'
            : 'Pregunta rechazada exitosamente.'),
      ));
      QuizItem removedItem = quizItemsNew.removeAt(index);
      builder(context, Animation<double> animation) {
        return _buildItem(removedItem, index, animation);
      }

      _listKey.currentState?.removeItem(index, builder);

      Future.delayed(const Duration(seconds: 1)).then((value) {
        widget.updateQuizAnswers(quizItemsNew);
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Hubo un error al intentar aprobar la pregunta.'),
      ));
    });
  }

  Widget _buildItem(QuizItem item, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          return OutlinedCard(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.space18, vertical: Constants.space21),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: state.approvingQuizItemLoading
                      ? const SizedBox(
                          height: 120,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pregunta',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.question),
                            const SizedBox(height: Constants.space16),
                            const Text('Respuesta correcta',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.correctAnswer),
                            const SizedBox(height: Constants.space16),
                            const Text('Explicación',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.explanation),
                            const SizedBox(height: Constants.space16),
                            const Text('Opción 2',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.options[1]),
                            const SizedBox(height: Constants.space16),
                            const Text('Opción 3',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.options[2]),
                            const SizedBox(height: Constants.space16),
                            const Text('Opción 4',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(item.options[3]),
                            const SizedBox(height: Constants.space16),
                            Row(children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    submit(
                                        true, index, context.read<QuizCubit>());
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      SizedBox(width: 12),
                                      Text('Aprobar'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: Constants.space16),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    submit(false, index,
                                        context.read<QuizCubit>());
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.close, color: Colors.red),
                                      SizedBox(width: 12),
                                      Text('Rechazar'),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                          ],
                        )));
        },
      ),
    );
  }
}

class PendingQuizEmptyState extends StatelessWidget {
  const PendingQuizEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child:
                  SvgPicture.asset('assets/icons/achievement-outline-icon.svg'),
            ),
            const SizedBox(height: Constants.space21),
            const Text('No tienes por ahora preguntas pendientes de aprobar',
                textAlign: TextAlign.center),
            const SizedBox(height: Constants.space41),
          ]),
    );
  }
}
