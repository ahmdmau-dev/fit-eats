/// Application route names
class Routes {
  Routes._();

  // Root
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  // Onboarding Steps
  static const String healthGoal = '/onboarding/health-goal';
  static const String dietType = '/onboarding/diet-type';
  static const String allergies = '/onboarding/allergies';
  static const String workoutLevel = '/onboarding/workout-level';
  static const String workoutType = '/onboarding/workout-type';

  // Main Navigation
  static const String home = '/home';
  static const String mealPlans = '/meal-plans';
  static const String workouts = '/workouts';
  static const String profile = '/profile';

  // Meal Planning
  static const String mealPlanGenerator = '/meal-plans/generator';
  static const String mealPlanDetail = '/meal-plans/:id';
  static const String recipeDetail = '/meal-plans/:planId/recipe/:recipeId';
  static const String shoppingList = '/shopping-list';

  // Workout Planning
  static const String workoutGenerator = '/workouts/generator';
  static const String workoutDetail = '/workouts/:id';
  static const String workoutPlayer = '/workouts/:id/player';

  // Settings & Profile
  static const String settings = '/settings';
  static const String editPreferences = '/profile/edit';
  static const String aiConfig = '/settings/ai-config';
  static const String themeSettings = '/settings/theme';
  static const String about = '/settings/about';
}
