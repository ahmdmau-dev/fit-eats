import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preference_model.freezed.dart';
part 'user_preference_model.g.dart';

@freezed
class UserPreferenceModel with _$UserPreferenceModel {
  const factory UserPreferenceModel({
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
  }) = _UserPreferenceModel;

  const UserPreferenceModel._();

  factory UserPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreferenceModelFromJson(json);

  /// Convert from entity
  factory UserPreferenceModel.fromEntity(UserPreference entity) {
    return UserPreferenceModel(
      id: entity.id,
      userId: entity.userId,
      healthGoal: entity.healthGoal,
      dietType: entity.dietType,
      allergies: entity.allergies,
      workoutLevel: entity.workoutLevel,
      workoutType: entity.workoutType,
      dailyCalorieTarget: entity.dailyCalorieTarget,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      notes: entity.notes,
    );
  }

  /// Convert to entity
  UserPreference toEntity() {
    return UserPreference(
      id: id,
      userId: userId,
      healthGoal: healthGoal,
      dietType: dietType,
      allergies: allergies,
      workoutLevel: workoutLevel,
      workoutType: workoutType,
      dailyCalorieTarget: dailyCalorieTarget,
      createdAt: createdAt,
      updatedAt: updatedAt,
      notes: notes,
    );
  }
}
