import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/entities/story_entity.dart';

class StorySummaryMetadata extends StatelessWidget {
  const StorySummaryMetadata({
    super.key,
    this.readNumber = 0,
    this.readingTime,
  });

  final int readNumber;
  final ReadTimeResults? readingTime;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _RowItem(
            svgIconPath: 'assets/icons/eye-small-icon.svg',
            label: 'Leídas',
            value: readNumber.toString(),
          ),
          VerticalDivider(
            width: 32,
            thickness: 2,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            endIndent: 25,
          ),
          _RowItem(
            svgIconPath: 'assets/icons/clock-small-icon.svg',
            label: 'Tiempo',
            value: '${readingTime?.minutes.round() ?? 0} min',
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem(
      {required this.svgIconPath,
      required this.label,
      required this.value});
  final String svgIconPath;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(svgIconPath,
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )),
            ],
          ),
          Text(value,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
