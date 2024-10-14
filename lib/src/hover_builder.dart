import 'package:flutter/material.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A builder to adapt to the widget being hoverd or not.
class HoverBuilder extends HoverableWidget {
  /// A builder to adapt to the widget being hoverd or not.
  const HoverBuilder({
    super.key,
    required this.builder,
    super.cursor = kDefaultHoverCursor,
    super.onTap,
  });

  /// The builder to build the widget based if the user is hovering over it or not.
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(BuildContext context, bool isHovering) builder;

  @override
  Widget build(BuildContext context, bool isHovering) =>
      builder(context, isHovering);
}
