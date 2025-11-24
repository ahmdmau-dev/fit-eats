import 'package:fiteats/src/data/models/workout_plan_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveWorkoutPlanLocalDataSource {
  Future<void> saveWorkoutPlan(WorkoutPlanModel workoutPlan);
  Future<WorkoutPlanModel?> getWorkoutPlan(String id);
  Future<WorkoutPlanModel?> getWorkoutPlanByDate(DateTime date);
  Future<void> deleteWorkoutPlan(String id);
  Future<List<WorkoutPlanModel>> getAllWorkoutPlans();
  Future<List<WorkoutPlanModel>> getWorkoutPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  );
  Future<List<WorkoutPlanModel>> getCompletedWorkoutPlans();
  Future<void> toggleCompletion(String id);
}

@LazySingleton(as: HiveWorkoutPlanLocalDataSource)
class HiveWorkoutPlanLocalDataSourceImpl
    implements HiveWorkoutPlanLocalDataSource {
  HiveWorkoutPlanLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;
  static const String _keyPrefix = 'workout_plan_';

  String _getWorkoutPlanKey(String id) => '$_keyPrefix$id';

  @override
  Future<void> saveWorkoutPlan(WorkoutPlanModel workoutPlan) async {
    final key = _getWorkoutPlanKey(workoutPlan.id);
    await _box.put(key, workoutPlan.toJson());
  }

  @override
  Future<WorkoutPlanModel?> getWorkoutPlan(String id) async {
    final key = _getWorkoutPlanKey(id);
    final data = _box.get(key);
    if (data == null) return null;

    return WorkoutPlanModel.fromJson(Map<String, dynamic>.from(data as Map));
  }

  @override
  Future<WorkoutPlanModel?> getWorkoutPlanByDate(DateTime date) async {
    final allWorkoutPlans = await getAllWorkoutPlans();

    // Compare only the date part (ignore time)
    final targetDate = DateTime(date.year, date.month, date.day);

    try {
      return allWorkoutPlans.firstWhere(
        (plan) {
          final planDate = DateTime(
            plan.date.year,
            plan.date.month,
            plan.date.day,
          );
          return planDate == targetDate;
        },
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteWorkoutPlan(String id) async {
    final key = _getWorkoutPlanKey(id);
    await _box.delete(key);
  }

  @override
  Future<List<WorkoutPlanModel>> getAllWorkoutPlans() async {
    final allKeys =
        _box.keys.where((key) => key.toString().startsWith(_keyPrefix));
    final workoutPlans = <WorkoutPlanModel>[];

    for (final key in allKeys) {
      final data = _box.get(key);
      if (data != null) {
        workoutPlans.add(
          WorkoutPlanModel.fromJson(Map<String, dynamic>.from(data as Map)),
        );
      }
    }

    // Sort by date (most recent first)
    workoutPlans.sort((a, b) => b.date.compareTo(a.date));

    return workoutPlans;
  }

  @override
  Future<List<WorkoutPlanModel>> getWorkoutPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allWorkoutPlans = await getAllWorkoutPlans();

    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    return allWorkoutPlans.where((plan) {
      final planDate =
          DateTime(plan.date.year, plan.date.month, plan.date.day);
      return (planDate.isAfter(start) || planDate.isAtSameMomentAs(start)) &&
          (planDate.isBefore(end) || planDate.isAtSameMomentAs(end));
    }).toList();
  }

  @override
  Future<List<WorkoutPlanModel>> getCompletedWorkoutPlans() async {
    final allWorkoutPlans = await getAllWorkoutPlans();
    return allWorkoutPlans.where((plan) => plan.isCompleted).toList();
  }

  @override
  Future<void> toggleCompletion(String id) async {
    final workoutPlan = await getWorkoutPlan(id);
    if (workoutPlan != null) {
      final updatedPlan = workoutPlan.copyWith(
        isCompleted: !workoutPlan.isCompleted,
        updatedAt: DateTime.now(),
      );
      await saveWorkoutPlan(updatedPlan);
    }
  }
}
