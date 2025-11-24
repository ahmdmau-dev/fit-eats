import 'package:fiteats/src/core/config/routes.dart';
import 'package:fiteats/src/presentation/screens/home/home_screen.dart';
import 'package:fiteats/src/presentation/screens/meal_plans/meal_plans_screen.dart';
import 'package:fiteats/src/presentation/screens/onboarding/welcome_screen.dart';
import 'package:fiteats/src/presentation/screens/shopping_list/shopping_list_screen.dart';
import 'package:fiteats/src/presentation/screens/workouts/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration using GoRouter
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// GoRouter instance
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,
    routes: [
      // Splash/Welcome Screen
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const WelcomeScreen(),
      ),

      // Onboarding Flow
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const _PlaceholderPage(name: 'Onboarding'),
        routes: [
          GoRoute(
            path: 'health-goal',
            name: 'health-goal',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Health Goal'),
          ),
          GoRoute(
            path: 'diet-type',
            name: 'diet-type',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Diet Type'),
          ),
          GoRoute(
            path: 'allergies',
            name: 'allergies',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Allergies'),
          ),
          GoRoute(
            path: 'workout-level',
            name: 'workout-level',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Workout Level'),
          ),
          GoRoute(
            path: 'workout-type',
            name: 'workout-type',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Workout Type'),
          ),
        ],
      ),

      // Main App with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _PlaceholderShell(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Meal Plans Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.mealPlans,
                name: 'meal-plans',
                builder: (context, state) => const MealPlansScreen(),
                routes: [
                  GoRoute(
                    path: 'generator',
                    name: 'meal-plan-generator',
                    builder: (context, state) =>
                        const _PlaceholderPage(name: 'Meal Plan Generator'),
                  ),
                  GoRoute(
                    path: ':id',
                    name: 'meal-plan-detail',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return _PlaceholderPage(name: 'Meal Plan $id');
                    },
                    routes: [
                      GoRoute(
                        path: 'recipe/:recipeId',
                        name: 'recipe-detail',
                        builder: (context, state) {
                          final recipeId = state.pathParameters['recipeId']!;
                          return _PlaceholderPage(name: 'Recipe $recipeId');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Workouts Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.workouts,
                name: 'workouts',
                builder: (context, state) => const WorkoutsScreen(),
                routes: [
                  GoRoute(
                    path: 'generator',
                    name: 'workout-generator',
                    builder: (context, state) =>
                        const _PlaceholderPage(name: 'Workout Generator'),
                  ),
                  GoRoute(
                    path: ':id',
                    name: 'workout-detail',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return _PlaceholderPage(name: 'Workout $id');
                    },
                    routes: [
                      GoRoute(
                        path: 'player',
                        name: 'workout-player',
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return _PlaceholderPage(name: 'Player $id');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                name: 'profile',
                builder: (context, state) =>
                    const _PlaceholderPage(name: 'Profile'),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'edit-preferences',
                    builder: (context, state) =>
                        const _PlaceholderPage(name: 'Edit Preferences'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Settings (Full Screen)
      GoRoute(
        path: Routes.settings,
        name: 'settings',
        builder: (context, state) => const _PlaceholderPage(name: 'Settings'),
        routes: [
          GoRoute(
            path: 'ai-config',
            name: 'ai-config',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'AI Config'),
          ),
          GoRoute(
            path: 'theme',
            name: 'theme-settings',
            builder: (context, state) =>
                const _PlaceholderPage(name: 'Theme Settings'),
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (context, state) => const _PlaceholderPage(name: 'About'),
          ),
        ],
      ),

      // Shopping List (Full Screen)
      GoRoute(
        path: Routes.shoppingList,
        name: 'shopping-list',
        builder: (context, state) => const ShoppingListScreen(),
      ),
    ],
  );
}

// Placeholder widgets (will be replaced with actual screens)
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(
              'This screen will be implemented later',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderShell extends StatelessWidget {
  const _PlaceholderShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Meals'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
