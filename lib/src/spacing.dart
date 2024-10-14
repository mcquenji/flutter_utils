import 'package:flutter/cupertino.dart';

/// A utility class for creating consistent spacing throughout your Flutter app.
///
/// It provides predefined spacing options for both vertical and horizontal spacing,
/// including extra small (xs), small, medium, large, and extra large (xl) sizes.
///
/// You can create spacing in all directions or specify spacing only vertically
/// or horizontally using the appropriate named constructors.
///
/// Example usage:
///
/// ```dart
/// Spacing.small() // Creates small spacing in both vertical and horizontal directions.
/// Spacing.mediumVertical() // Creates medium spacing only in the vertical direction.
/// Spacing.xlHorizontal() // Creates extra large spacing only in the horizontal direction.
/// ```
///
/// ### Modifying Spacing Values
///
/// If you need to adjust the predefined spacing values, you can modify the static
/// properties directly:
///
/// ```dart
/// Spacing.smallSpacing = 12; // Changes the small spacing to 12 pixels.
/// Spacing.largeSpacing = 30; // Changes the large spacing to 30 pixels.
/// ```
///
/// This class makes it easier to maintain consistent spacing throughout the UI
/// without manually specifying the width and height each time.
class Spacing extends SizedBox {
  const Spacing._({
    super.key,
    super.width = 0.0,
    super.height = 0.0,
  });

  /// Both vertical and horizontal [xsSpacing]
  Spacing.xs({Key? key})
      : this._(key: key, height: xsSpacing, width: xsSpacing);

  /// Both vertical and horizontal [smallSpacing]
  Spacing.small({Key? key})
      : this._(key: key, height: smallSpacing, width: smallSpacing);

  /// Both vertical and horizontal [mediumSpacing]
  Spacing.medium({Key? key})
      : this._(key: key, height: mediumSpacing, width: mediumSpacing);

  /// Both vertical and horizontal [largeSpacing]
  Spacing.large({Key? key})
      : this._(key: key, height: largeSpacing, width: largeSpacing);

  /// Both vertical and horizontal [xlSpacing]
  Spacing.xl({Key? key})
      : this._(key: key, height: xlSpacing, width: xlSpacing);

  /// Vertical [xsSpacing]
  Spacing.xsVertical({Key? key}) : this._(key: key, height: xsSpacing);

  /// Vertical [smallSpacing]
  Spacing.smallVertical({Key? key}) : this._(key: key, height: smallSpacing);

  /// Vertical [mediumSpacing]
  Spacing.mediumVertical({Key? key}) : this._(key: key, height: mediumSpacing);

  /// Vertical [largeSpacing]
  Spacing.largeVertical({Key? key}) : this._(key: key, height: largeSpacing);

  /// Vertical [xlSpacing]
  Spacing.xlVertical({Key? key}) : this._(key: key, height: xlSpacing);

  /// Horizontal [xsSpacing]
  Spacing.xsHorizontal({Key? key}) : this._(key: key, width: xsSpacing);

  /// Horizontal [smallSpacing]
  Spacing.smallHorizontal({Key? key}) : this._(key: key, width: smallSpacing);

  /// Horizontal [mediumSpacing]
  Spacing.mediumHorizontal({Key? key}) : this._(key: key, width: mediumSpacing);

  /// Horizontal [largeSpacing]
  Spacing.largeHorizontal({Key? key}) : this._(key: key, width: largeSpacing);

  /// Horizontal [xlSpacing]
  Spacing.xlHorizontal({Key? key}) : this._(key: key, width: xlSpacing);

  /// Value for extra small spacing.
  static double xsSpacing = 5;

  /// Value for small spacing.
  static double smallSpacing = 10;

  /// Value for medium spacing.
  static double mediumSpacing = 20;

  /// Value for large spacing.
  static double largeSpacing = 25;

  /// Value for extra large spacing.
  static double xlSpacing = 30;
}
