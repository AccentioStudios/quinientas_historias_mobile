import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';

class ReadingStoryOptionsSheetView extends StatefulWidget {
  const ReadingStoryOptionsSheetView({Key? key}) : super(key: key);

  @override
  State<ReadingStoryOptionsSheetView> createState() =>
      _ReadingStoryOptionsSheetViewState();
}

class _ReadingStoryOptionsSheetViewState
    extends State<ReadingStoryOptionsSheetView> {
  late double textSize;

  @override
  void initState() {
    textSize =
        context.read<ReadingStoryCubit>().state.readingOptions.fontSizeBase;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    var textStyle2 = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: PaddingColumn(
            padding: const EdgeInsets.all(Constants.space21),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tamaño del texto', style: textStyle),
              const SizedBox(height: Constants.space8),
              Flex(
                direction: Axis.horizontal,
                children: [
                  const Text('Aa',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Slider(
                      thumbColor: Theme.of(context).colorScheme.primary,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (double value) {
                        context
                            .read<ReadingStoryCubit>()
                            .changeTextSize(fontSizeBase: value);
                        setState(() {
                          textSize = value;
                        });
                      },
                      value: textSize,
                      min: 16,
                      max: 25,
                      divisions: 8,
                    ),
                  ),
                  const Text('Aa',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: Constants.space8),
              Text('Tema', style: textStyle),
              const SizedBox(height: Constants.space8),
              ListTile(
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Modo Oscuro',
                  style: textStyle2,
                ),
                trailing: Switch.adaptive(
                    value: state.readingOptions.isDarkMode,
                    onChanged: (changed) {
                      context
                          .read<ReadingStoryCubit>()
                          .switchDarkMode(isDarkMode: changed);
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
