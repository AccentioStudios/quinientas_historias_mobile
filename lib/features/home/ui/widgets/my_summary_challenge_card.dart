import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/ui/widgets/link_button.dart';

import '../../../../core/ui/widgets/outlined_card.dart';
import '../../../../core/utils/constants.dart';
import '../../data/entities/dashboard_entity.dart';

class MySummaryChallengeCard extends StatelessWidget {
  const MySummaryChallengeCard({
    super.key,
    required this.summaryChallenge,
  });

  final MySummaryChallenge summaryChallenge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 277,
      height: 130,
      child: OutlinedCard(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space18, vertical: Constants.space18),
          child: Column(
            children: [
              // Title and description
              Flex(
                direction: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: Constants.space12),
                    child:
                        SizedBox(child: SvgPicture.asset(getChallengeIcon())),
                  ),
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 15),
                        text: summaryChallenge.summaryTitle,
                      ),
                      maxLines: 2,
                      minFontSize: 13,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (summaryChallenge.summaryDescription.isNotEmpty)
                const SizedBox(height: Constants.space8),
              if (summaryChallenge.summaryDescription.isNotEmpty)
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: AutoSizeText.rich(
                        TextSpan(
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontSize: 14),
                          text: '${summaryChallenge.summaryDescription} ',
                        ),
                        maxLines: 2,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              const Spacer(),
              // Bottom row
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStepper(context),
                  const SizedBox(height: Constants.space8),
                  buildButtomLink()
                ],
              )
            ],
          )),
    );
  }

  String getChallengeIcon() {
    switch (summaryChallenge.challengeType) {
      case ChallengeType.steps:
        return 'assets/icons/challenge-steps-outline-icon.svg';
      case ChallengeType.minigame:
        return 'assets/icons/challenge-minigame-outline-icon.svg';
      case ChallengeType.questions:
        return 'assets/icons/challenge-questions-outline-icon.svg';
      default:
        return 'assets/icons/challenge-steps-outline-icon.svg';
    }
  }

  Widget buildButtomLink() {
    switch (summaryChallenge.challengeType) {
      case ChallengeType.steps:
        break;
      case ChallengeType.minigame:
        return const Align(
          child: LinkButton(
            text: 'Jugar ahora',
            decoration: TextDecoration.none,
          ),
        );
      case ChallengeType.questions:
        return const Align(
          child: LinkButton(
            text: 'Ver preguntas',
            decoration: TextDecoration.none,
          ),
        );
      default:
        return const Align(
          child: LinkButton(
            text: 'Abrir',
            decoration: TextDecoration.none,
          ),
        );
    }

    return const SizedBox.shrink();
  }

  Widget buildStepper(BuildContext context) {
    if (summaryChallenge.challengeType == ChallengeType.steps) {
      return Expanded(
        child: AutoSizeText.rich(
          TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                text:
                    '${summaryChallenge.stepsCompleted} de ${summaryChallenge.steps} ',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' lecturas'),
            ],
          ),
          maxLines: 1,
          maxFontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
