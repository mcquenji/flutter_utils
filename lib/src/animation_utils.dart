/// A utility class that manages staggered animations by incrementing durations.
///
/// The [AnimationStagger] class is designed to help create staggered animation
/// effects by providing incrementally increasing durations for animations.
///
/// Example usage:
/// ```dart
/// final stagger = AnimationStagger(Duration(milliseconds: 200));
/// print(stagger[1]); // 200ms
/// print(stagger + 2); // 600ms
/// print(stagger.add()); // 600ms (index = 3)
/// ```
class AnimationStagger {
  /// The duration increment applied between each staggered animation.
  ///
  /// Defaults to `100ms` if not specified.
  final Duration increment;

  /// Creates an [AnimationStagger] with an optional [increment].
  ///
  /// The [increment] is the duration added between each staggered animation.
  /// If not provided, the increment defaults to 100 milliseconds.
  AnimationStagger([this.increment = const Duration(milliseconds: 100)]);

  int _index = 0;

  /// Returns the duration for the animation at the given [index].
  ///
  /// The duration is calculated as `increment * index`.
  Duration operator [](int index) => increment * index;

  /// Advances the internal index by [value] and returns the new duration.
  ///
  /// The duration is calculated as `increment * (_index += value)`.
  Duration operator +(int value) => increment * (_index += value);

  /// Returns the current stagger duration and then increments the internal index.
  ///
  /// The duration is calculated as `increment * _index`, and the internal index
  /// is incremented by 1 after each call.
  Duration add() => increment * _index++;
}
