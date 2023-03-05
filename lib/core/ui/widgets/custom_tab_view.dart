import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView(
      {super.key, required this.tabController, required this.children});
  final TabController tabController;
  final List<Widget> children;

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: [
        ...widget.children.map((child) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx.isNegative) {
                if (widget.tabController.index >=
                    widget.tabController.length - 1) {
                  return;
                }
                setState(() {
                  widget.tabController.index += 1;
                });

                return;
              }
              setState(() {
                if (widget.tabController.index != 0) {
                  widget.tabController.index -= 1;
                }
              });
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: child,
            ),
          );
        })
      ][widget.tabController.index],
    );
  }
}
