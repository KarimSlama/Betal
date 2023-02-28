import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({
    Key? key,
    required this.context,
    required this.isExpanded,
  }) : super(key: key);

  final BuildContext context;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {

      },
      icon: Icon(
        isExpanded ? Icons.expand_less : Icons.expand_more,
        color: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
    );
  }
}
