import 'package:fiteats/src/core/constants/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preference.freezed.dart';

/// User preferences for meal and workout planning
@freezed
class UserPreference with _$UserPreference {
  const factory UserPreference({
    required String id,
    required String userId,
    required HealthGoal healthGoal,
    required DietType dietType,
    required List<Allergy> allergies,
    required WorkoutLevel workoutLevel,
    required WorkoutType workoutType,
    required int dailyCalorieTarget,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? notes,
  }) = _UserPreference;

  const UserPreference._();

  /// Empty preference for initialization
  UserPreference empty() => UserPreference(
    id: '',
    userId: '',
    healthGoal: HealthGoal.maintainHealth,
    dietType: DietType.normal,
    allergies: const [],
    workoutLevel: WorkoutLevel.beginner,
    workoutType: WorkoutType.mixed,
    dailyCalorieTarget: 2000,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
