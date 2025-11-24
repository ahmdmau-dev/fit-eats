import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/usecases/meal_plan/get_meal_plan_by_date_usecase.dart';
import 'package:fiteats/src/domain/usecases/meal_plan/save_meal_plan_usecase.dart';
import 'package:fiteats/src/presentation/blocs/meal_plan/meal_plan_event.dart';
import 'package:fiteats/src/presentation/blocs/meal_plan/meal_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  MealPlanBloc(
    this._getMealPlanByDateUseCase,
    this._saveMealPlanUseCase,
  ) : super(const MealPlanState.initial()) {
    on<LoadMealPlanByDateEvent>(_onLoadMealPlanByDate);
    on<SaveMealPlanEvent>(_onSaveMealPlan);
    on<GenerateMealPlanEvent>(_onGenerateMealPlan);
  }

  final GetMealPlanByDateUseCase _getMealPlanByDateUseCase;
  final SaveMealPlanUseCase _saveMealPlanUseCase;

  Future<void> _onLoadMealPlanByDate(
    LoadMealPlanByDateEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(const MealPlanState.loading());

    final result = await _getMealPlanByDateUseCase(event.date);

    result.fold(
      (failure) => emit(MealPlanState.error(failure.userMessage)),
      (mealPlan) => emit(MealPlanState.loaded(mealPlan)),
    );
  }

  Future<void> _onSaveMealPlan(
    SaveMealPlanEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(const MealPlanState.saving());

    final result = await _saveMealPlanUseCase(event.mealPlan);

    result.fold(
      (failure) => emit(MealPlanState.error(failure.userMessage)),
      (_) => emit(const MealPlanState.saved()),
    );
  }

  Future<void> _onGenerateMealPlan(
    GenerateMealPlanEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(const MealPlanState.generating());

    // TODO: Implement AI meal plan generation
    // This will be implemented in Phase 5
    emit(
      const MealPlanState.error(
        'AI meal plan generation is not yet implemented',
      ),
    );
  }
}
