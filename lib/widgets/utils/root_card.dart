import 'package:fi/widgets/utils/conditiona_parent_widget.dart';
import 'package:flutter/material.dart';

class RootCard extends StatelessWidget {

  final Widget child;

  final void Function()? onTap;

  const RootCard({
    Key? key,
    required this.child, 
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ConditionalParentWidget(
        condition: onTap != null,
        conditionalBuilder: (child) => InkWell(child: child, onTap: onTap),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: child,
        )
      )
    );
  }
}