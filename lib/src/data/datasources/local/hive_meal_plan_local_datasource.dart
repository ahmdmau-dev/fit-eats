import 'package:fiteats/src/data/models/meal_plan_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveMealPlanLocalDataSource {
  Future<void> saveMealPlan(MealPlanModel mealPlan);
  Future<MealPlanModel?> getMealPlan(String id);
  Future<MealPlanModel?> getMealPlanByDate(DateTime date);
  Future<void> deleteMealPlan(String id);
  Future<List<MealPlanModel>> getAllMealPlans();
  Future<List<MealPlanModel>> getMealPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  );
}

@LazySingleton(as: HiveMealPlanLocalDataSource)
class HiveMealPlanLocalDataSourceImpl implements HiveMealPlanLocalDataSource {
  HiveMealPlanLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;
  static const String _keyPrefix = 'meal_plan_';

  String _getMealPlanKey(String id) => '$_keyPrefix$id';

  @override
  Future<void> saveMealPlan(MealPlanModel mealPlan) async {
    final key = _getMealPlanKey(mealPlan.id);
    await _box.put(key, mealPlan.toJson());
  }

  @override
  Future<MealPlanModel?> getMealPlan(String id) async {
    final key = _getMealPlanKey(id);
    final data = _box.get(key);
    if (data == null) return null;

    return MealPlanModel.fromJson(Map<String, dynamic>.from(data as Map));
  }

  @override
  Future<MealPlanModel?> getMealPlanByDate(DateTime date) async {
    final allMealPlans = await getAllMealPlans();

    // Compare only the date part (ignore time)
    final targetDate = DateTime(date.year, date.month, date.day);

    try {
      return allMealPlans.firstWhere(
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
  Future<void> deleteMealPlan(String id) async {
    final key = _getMealPlanKey(id);
    await _box.delete(key);
  }

  @override
  Future<List<MealPlanModel>> getAllMealPlans() async {
    final allKeys = _box.keys.where((key) => key.toString().startsWith(_keyPrefix));
    final mealPlans = <MealPlanModel>[];

    for (final key in allKeys) {
      final data = _box.get(key);
      if (data != null) {
        mealPlans.add(
          MealPlanModel.fromJson(Map<String, dynamic>.from(data as Map)),
        );
      }
    }

    // Sort by date (most recent first)
    mealPlans.sort((a, b) => b.date.compareTo(a.date));

    return mealPlans;
  }

  @override
  Future<List<MealPlanModel>> getMealPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allMealPlans = await getAllMealPlans();

    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    return allMealPlans.where((plan) {
      final planDate = DateTime(plan.date.year, plan.date.month, plan.date.day);
      return (planDate.isAfter(start) || planDate.isAtSameMomentAs(start)) &&
          (planDate.isBefore(end) || planDate.isAtSameMomentAs(end));
    }).toList();
  }
}
