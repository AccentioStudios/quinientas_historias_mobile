import 'package:flutter/material.dart';

class LayoutWithFooter extends StatelessWidget {
  const LayoutWithFooter({
    super.key,
    required this.footer,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.alignmentFooter = Alignment.bottomCenter,
    this.padding,
    this.paddingFooter,
  });

  final Widget footer;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry alignmentFooter;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingFooter;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: padding != null ? padding! : const EdgeInsets.all(0.1),
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: paddingFooter != null
                ? paddingFooter!
                : const EdgeInsets.all(0.1),
            child: Align(
              alignment: alignmentFooter,
              child: footer,
            ),
          ),
        )
      ],
    );
  }
}
