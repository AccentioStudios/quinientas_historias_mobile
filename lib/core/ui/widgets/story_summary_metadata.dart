import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StorySummaryMetadata extends StatelessWidget {
  const StorySummaryMetadata({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          _RowItem(
            svgIconPath: 'assets/icons/eye-small-icon.svg',
            label: 'Leídas',
            value: '85',
          ),
          VerticalDivider(
            width: 32,
            thickness: 2,
            color: Colors.white,
            endIndent: 25,
          ),
          _RowItem(
            svgIconPath: 'assets/icons/clock-small-icon.svg',
            label: 'Tiempo',
            value: '10 min',
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem(
      {Key? key,
      required this.svgIconPath,
      required this.label,
      required this.value})
      : super(key: key);
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
                  width: 16, height: 16, child: SvgPicture.asset(svgIconPath)),
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
