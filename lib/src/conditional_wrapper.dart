import 'package:flutter/material.dart';

/// A widget that conditionally wraps its [child] with a [wrapper] widget.
/// If [condition] is false, just the [child] will be returned.
class ConditionalWrapper extends StatelessWidget {
  /// A widget that conditionally wraps its [child] with a [wrapper] widget.
  /// If [condition] is false, just the [child] will be returned.
  const ConditionalWrapper({super.key, required this.child, required this.condition, required this.wrapper});

  /// The widget that will be wrapped if [condition] is true.
  final Widget child;

  /// The condition that determines whether [child] will be wrapped.
  final bool condition;

  /// The wrapper that will be used to wrap [child] if [condition] is true.
  final Widget Function(BuildContext context, Widget child) wrapper;

  @override
  Widget build(BuildContext context) => condition ? wrapper(context, child) : child;
}
