import 'package:flutter/material.dart';

/// Extension on [BuildContext] that provides adaptive layout checks.
///
/// This extension adds convenient getters to determine if the app should
/// use the mobile or desktop layout based on the current [MediaQuery] size.
extension AdaptiveContext on BuildContext {
  /// Returns `true` if the current [BuildContext] qualifies for the mobile layout.
  ///
  /// The decision is based on the [Adaptive.mobileBreakpoint] and [Adaptive.ignoreHeight]
  /// settings.
  bool get isMobile => Adaptive.isMobile(this);

  /// Returns `true` if the current [BuildContext] qualifies for the desktop layout.
  ///
  /// This is simply the inverse of [isMobile].
  bool get isDesktop => !isMobile;
}

/// Mixin for [StatefulWidget]s that need to build adaptive layouts.
///
/// This mixin implements the [Adaptive] interface and delegates widget
/// building to the static [Adaptive.build] method. Use it when you want your
/// [State] to render different layouts for mobile and desktop devices.
mixin AdaptiveState<T extends StatefulWidget> on State<T> implements Adaptive {
  @override
  Widget build(BuildContext context) => Adaptive.build(context, this);

  @override
  Widget transitionBuilder(Widget child, Animation<double> animation, BuildContext context) =>
      Adaptive.defaultTransitionBuilder(child, animation, context);
}

/// Mixin for [StatelessWidget]s that need to build adaptive layouts.
///
/// This mixin implements the [Adaptive] interface and delegates widget
/// building to the static [Adaptive.build] method. Use it when you want your
/// widget to render different layouts for mobile and desktop devices.
mixin AdaptiveWidget on StatelessWidget implements Adaptive {
  @override
  Widget build(BuildContext context) => Adaptive.build(context, this);

  @override
  Widget transitionBuilder(Widget child, Animation<double> animation, BuildContext context) =>
      Adaptive.defaultTransitionBuilder(child, animation, context);
}

/// Abstract class that provides an adaptive layout system for Flutter widgets.
///
/// This class defines the interface and default behavior for building
/// different widget trees based on the device's size. It provides methods to
/// determine whether to use the mobile or desktop layout and animates the
/// transition between these layouts.
abstract class Adaptive {
  /// The breakpoint size at which the app switches to the mobile layout.
  ///
  /// This value is used to determine if the current screen qualifies as mobile.
  /// You can adjust it to fit your design requirements. Defaults to 600x800.
  static Size mobileBreakpoint = const Size(600, 800);

  /// Whether to ignore the screen height when determining the layout.
  ///
  /// When set to `true`, only the width is considered when deciding whether to
  /// use the mobile layout. Defaults to `false`, meaning both width and height are
  /// taken into account.
  static bool ignoreHeight = false;

  /// Determines whether the app should use the mobile layout.
  ///
  /// Returns `true` if the screen's width is less than [Adaptive.mobileBreakpoint.width] or,
  /// if [ignoreHeight] is `false`, if the height is also below [Adaptive.mobileBreakpoint.height].
  static bool isMobile(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width < mobileBreakpoint.width || (!ignoreHeight && size.height < mobileBreakpoint.height);
  }

  /// Determines whether the app should use the desktop layout.
  ///
  /// This is simply the inverse of [isMobile].
  static bool isDesktop(BuildContext context) => !isMobile(context);

  /// The default transition builder for adaptive layouts.
  /// Set this property to a custom transition builder to change the transition on a global level.
  ///
  /// To change the transition on a per-widget basis, override the [transitionBuilder] method, which takes precedence over this property.
  static Widget Function(Widget, Animation<double>, BuildContext) defaultTransitionBuilder = (child, animation, context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = context.isMobile;
    Offset beginOffset;

    if (isMobile) {
      // Determine the trigger based on height or width.
      if (mediaQuery.size.height < 600) {
        // Mobile due to low height: slide in from the bottom.
        beginOffset = const Offset(0, 0.3);
      } else if (mediaQuery.size.width < 600) {
        // Mobile due to low width: slide in from the left.
        beginOffset = const Offset(-0.3, 0);
      } else {
        // Fallback option.
        beginOffset = const Offset(0, 0.3);
      }
    } else {
      // Desktop: use a subtle slide from the bottom.
      beginOffset = const Offset(0, 0.1);
    }

    // Apply an elastic bounce effect to the transition.
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.elasticOut,
    );

    final slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(curved);

    final scale = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(curved);

    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: scale,
          child: child,
        ),
      ),
    );
  };

  /// Builds the transition for the adaptive layout.
  /// Called by the [AnimatedSwitcher] to animate the transition between the mobile and desktop layouts.
  ///
  /// You can override this method to provide a custom transition for your adaptive layout on a per-widget basis. By default, it uses the [defaultTransitionBuilder].
  /// Changing this method takes precedence over the global transition builder.
  ///
  /// To customize the transition on a global level, set the [defaultTransitionBuilder].
  Widget transitionBuilder(Widget child, Animation<double> animation, BuildContext context) => defaultTransitionBuilder(child, animation, context);

  /// Builds the widget tree based on the current device's layout.
  static Widget build(BuildContext context, Adaptive adaptive) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => defaultTransitionBuilder(child, animation, context),
      child: isMobile(context) ? adaptive.buildMobile(context) : adaptive.buildDesktop(context),
    );
  }

  /// Builds the widget tree for mobile devices.
  ///
  /// Implement this method to define the layout when [isMobile] is `true`.
  Widget buildMobile(BuildContext context);

  /// Builds the widget tree for desktop devices.
  ///
  /// Implement this method to define the layout when [isMobile] is `false`.
  Widget buildDesktop(BuildContext context);
}
