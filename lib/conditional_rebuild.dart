// Flutter imports:
import 'package:flutter/material.dart';

typedef ConditionFunction<T> = bool Function(BuildContext, T, T);

@immutable
class ConditionalRebuild<T extends Widget> extends StatefulWidget {
  final ConditionFunction condition;
  final T child;
  const ConditionalRebuild(
      {Key? key, required this.condition, required this.child})
      : super(key: key);
  @override
  State<ConditionalRebuild> createState() => _ConditionalRebuildState<T>();
}

class _ConditionalRebuildState<T extends Widget>
    extends State<ConditionalRebuild> {
  T? lastBuild;
  @override
  Widget build(context) {
    final newBuild = widget.child as T;
    if (lastBuild == null ||
        widget.condition(context, lastBuild as T, newBuild)) {
      lastBuild = newBuild;
    }
    return lastBuild!;
  }
}
