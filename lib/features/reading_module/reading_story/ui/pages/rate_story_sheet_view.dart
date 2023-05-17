import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quinientas_historias/core/ui/widgets/link_button.dart';
import 'package:quinientas_historias/core/utils/colors.dart';
import 'package:rive/rive.dart';

import '../../../../../core/data/models/rate_story_request.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';

class RateStorySheetView extends StatefulWidget {
  const RateStorySheetView({super.key, required this.state});

  final ReadingStoryState state;

  @override
  State<RateStorySheetView> createState() => _RateStorySheetViewState();
}

class _RateStorySheetViewState extends State<RateStorySheetView> {
  bool isLoading = false;
  bool expanded = true;

  int? niceRating;
  int? qualityRating;
  int? veracityRating;
  int? originalityRating;
  int? educationalRating;

  @override
  void initState() {
    super.initState();
    niceRating = widget.state.myRating?.niceRating;
    qualityRating = widget.state.myRating?.qualityRating;
    veracityRating = widget.state.myRating?.veracityRating;
    originalityRating = widget.state.myRating?.originalityRating;
    educationalRating = widget.state.myRating?.educationalRating;
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return AnimatedContainer(
      height: expanded ? 670 : 530,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutQuad,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: PaddingColumn(
          padding: const EdgeInsets.all(Constants.space21),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: Constants.space4),
            SizedBox(
                width: 48,
                height: 48,
                child: SvgPicture.asset('assets/icons/star-rating-icon.svg')),
            const SizedBox(height: Constants.space12),
            Text(
              'Cuentanos tu opinión\nsobre la lectura',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.space18),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingInput(
                    initRate: niceRating,
                    label: '¿Que tanto te gustó la historia?',
                    isRequired: true,
                    onChanged: (rating) {
                      setState(() {
                        niceRating = rating;
                      });
                    },
                  ),
                  RatingInput(
                    initRate: qualityRating,
                    label: '¿Que tan bien escrita está?',
                    onChanged: (rating) {
                      setState(() {
                        qualityRating = rating;
                      });
                    },
                  ),
                  RatingInput(
                    initRate: veracityRating,
                    label: '¿Que tan creíble fué?',
                    onChanged: (rating) {
                      setState(() {
                        veracityRating = rating;
                      });
                    },
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: expanded == false
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              RatingInput(
                                initRate: originalityRating,
                                label: '¿Que tan original fué para ti?',
                                onChanged: (rating) {
                                  setState(() {
                                    originalityRating = rating;
                                  });
                                },
                              ),
                              RatingInput(
                                initRate: educationalRating,
                                label: '¿Que tan educativa fué para ti?',
                                onChanged: (rating) {
                                  setState(() {
                                    educationalRating = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                  ),
                  if (expanded == false)
                    LinkButton(
                      text: 'Calificar más cosas',
                      onTap: () {
                        showMoreOptions();
                      },
                    ),
                  const SizedBox(height: Constants.space30),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BigButton(
                          isLoading: isLoading,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 16),
                          onPressed: () {
                            rateStory(context, widget.state);
                          },
                          text: 'Continuar',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.space12),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showMoreOptions() {
    setState(() {
      expanded = true;
    });
  }

  void rateStory(BuildContext context, ReadingStoryState state) {
    if (niceRating == null) {
      Fluttertoast.showToast(
          msg: 'Por favor, califica que tanto te gustó la historia');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final RateStoryRequest request = RateStoryRequest(
      niceRating: niceRating,
      qualityRating: qualityRating,
      veracityRating: veracityRating,
      originalityRating: originalityRating,
      educationalRating: educationalRating,
    );

    context.read<ReadingStoryCubit>().rateStory(state.story!.id, request,
        onSuccess: () {
      return Navigator.of(context).pop(true);
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: 'Hay un problema al guardar, intenta otra vez');
    });
  }
}

class RatingInput extends StatefulWidget {
  const RatingInput(
      {super.key,
      this.initRate,
      required this.label,
      required this.onChanged,
      this.isRequired = false});
  final String label;
  final bool isRequired;
  final int? initRate;
  final void Function(int rating) onChanged;

  @override
  State<RatingInput> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingInput> {
  SMIInput<double>? _ratingInput;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label),
            if (widget.isRequired)
              const Text(
                'Obligatorio',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: primaryDarkColor),
              ),
          ],
        ),
        const SizedBox(height: Constants.space8),
        SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -21,
                left: -14,
                child: Container(
                    clipBehavior: Clip.none,
                    width: 230,
                    height: 70,
                    child: RiveAnimation.asset(
                      'assets/images/rating-animation.riv',
                      onInit: _onRiveInit,
                    )),
              ),
              Row(children: [
                GestureDetector(
                  child: Container(
                      width: 40, height: 35, color: Colors.transparent),
                  onTap: () => rate(1),
                ),
                GestureDetector(
                  child: Container(
                      width: 40, height: 35, color: Colors.transparent),
                  onTap: () => rate(2),
                ),
                GestureDetector(
                  child: Container(
                      width: 40, height: 35, color: Colors.transparent),
                  onTap: () => rate(3),
                ),
                GestureDetector(
                  child: Container(
                      width: 40, height: 35, color: Colors.transparent),
                  onTap: () => rate(4),
                ),
                GestureDetector(
                  child: Container(
                      width: 40, height: 35, color: Colors.transparent),
                  onTap: () => rate(5),
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: Constants.space21),
      ],
    );
  }

  void rate(int value) {
    setState(() {
      _ratingInput?.value = value.toDouble();
    });
    widget.onChanged(value);
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);
    _ratingInput = controller.findInput<double>('rating');

    if (widget.initRate != null) {
      setState(() {
        _ratingInput?.value = widget.initRate?.toDouble() ?? 0;
      });
    } else {
      setState(() {
        _ratingInput?.value = 0;
      });
    }
  }
}
