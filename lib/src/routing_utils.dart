import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A widget that wraps a [RouterOutlet] with the ability to activate a child route on default.
class InitialRouterOutlet extends StatelessWidget {
  /// A widget that wraps a [RouterOutlet] with the ability to activate a child route on default.
  const InitialRouterOutlet({super.key, required this.initialRoute});

  /// The path of the child route to activate on default.
  ///
  /// ```dart
  /// r.child(
  ///    "/",
  ///    child: (_) => const InitialRouterOutlet(
  ///        initialRoute: "/login",
  ///    ),
  ///    children: [
  ///      ParallelRoute(
  ///        name: "/login",
  ///        child: (_) => const LoginScreen(),
  ///      ),
  ///      ParallelRoute(
  ///        name: "/register",
  ///        child: (_) => const RegisterScreen(),
  ///      ),
  ///    ],
  /// );
  /// ```
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    var currentPath = Modular.to.path;

    if (currentPath.endsWith('/')) {
      currentPath = currentPath.substring(0, currentPath.length - 1);
    }

    final initialRoute = this.initialRoute.replaceFirst('/', '');

    Modular.to.pushReplacementNamed('$currentPath/$initialRoute');

    return const RouterOutlet();
  }
}

/// Extension to add a method to check if a route is active.
extension ActiveExt on IModularNavigator {
  /// Returns `true` if [path] starts with the given [route].
  bool isActive(String route) {
    return path.startsWith(route);
  }
}
