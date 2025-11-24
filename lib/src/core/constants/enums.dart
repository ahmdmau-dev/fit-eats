/// Health goals for meal and workout planning
enum HealthGoal {
  loseWeight('Lose Weight', 'Reduce body weight and fat percentage'),
  gainMuscle('Gain Muscle', 'Build muscle mass and strength'),
  maintainHealth('Maintain Health', 'Stay healthy and maintain current weight');

  const HealthGoal(this.label, this.description);

  final String label;
  final String description;
}

/// Diet types
enum DietType {
  normal('Normal', 'Balanced diet with all food groups'),
  vegan('Vegan', 'Plant-based diet with no animal products'),
  keto('Keto', 'Low-carb, high-fat diet'),
  lowCarb('Low-Carb', 'Reduced carbohydrate intake'),
  mediterranean('Mediterranean', 'Mediterranean-style diet');

  const DietType(this.label, this.description);

  final String label;
  final String description;
}

/// Common allergies
enum Allergy {
  seafood('Seafood', 'Fish, shellfish, and other seafood'),
  nuts('Nuts', 'Tree nuts and peanuts'),
  gluten('Gluten', 'Wheat, barley, and rye'),
  lactose('Lactose', 'Milk and dairy products'),
  eggs('Eggs', 'Chicken eggs'),
  soy('Soy', 'Soybeans and soy products'),
  none('None', 'No allergies');

  const Allergy(this.label, this.description);

  final String label;
  final String description;
}

/// Workout fitness levels
enum WorkoutLevel {
  beginner('Beginner', 'New to exercise or returning after a break'),
  intermediate('Intermediate', 'Regular exercise routine established'),
  advanced('Advanced', 'Experienced with intense training');

  const WorkoutLevel(this.label, this.description);

  final String label;
  final String description;
}

/// Workout types
enum WorkoutType {
  home('Home', 'Exercises that can be done at home'),
  gym('Gym', 'Exercises requiring gym equipment'),
  mixed('Mixed', 'Combination of home and gym workouts');

  const WorkoutType(this.label, this.description);

  final String label;
  final String description;
}

/// Meal times
enum MealTime {
  breakfast('Breakfast', '7:00 AM - 10:00 AM'),
  morningSnack('Morning Snack', '10:00 AM - 12:00 PM'),
  lunch('Lunch', '12:00 PM - 2:00 PM'),
  afternoonSnack('Afternoon Snack', '2:00 PM - 5:00 PM'),
  dinner('Dinner', '6:00 PM - 9:00 PM'),
  eveningSnack('Evening Snack', '9:00 PM - 11:00 PM');

  const MealTime(this.label, this.timeRange);

  final String label;
  final String timeRange;
}

/// Data storage modes
enum DataMode {
  offline('Offline', 'Data stored locally only'),
  firebase('Firebase', 'Data synced with Firebase'),
  supabase('Supabase', 'Data synced with Supabase');

  const DataMode(this.label, this.description);

  final String label;
  final String description;
}
