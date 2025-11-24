/// Application-wide constants
class AppConstants {
  AppConstants._();

  /// App Info
  static const String appName = 'FitEats AI';
  static const String appDescription = 'AI-Powered Meal & Workout Planner';

  /// Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'theme_mode';
  static const String onboardingKey = 'onboarding_completed';
  static const String mealPlansKey = 'meal_plans';
  static const String workoutPlansKey = 'workout_plans';
  static const String shoppingListKey = 'shopping_list';

  /// Hive Box Names
  static const String hiveBoxName = 'fiteats_box';
  static const String userBox = 'user_box';
  static const String mealBox = 'meal_box';
  static const String workoutBox = 'workout_box';

  /// Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  /// Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration aiTimeout = Duration(seconds: 60);

  /// Limits
  static const int maxMealsPerDay = 6;
  static const int maxExercisesPerWorkout = 20;
  static const int maxShoppingListItems = 100;

  /// Calories
  static const int minCalories = 1200;
  static const int maxCalories = 5000;
  static const int defaultCalories = 2000;
}
