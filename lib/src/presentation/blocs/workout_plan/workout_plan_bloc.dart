import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/usecases/workout_plan/get_workout_plan_by_date_usecase.dart';
import 'package:fiteats/src/domain/usecases/workout_plan/save_workout_plan_usecase.dart';
import 'package:fiteats/src/domain/usecases/workout_plan/toggle_workout_completion_usecase.dart';
import 'package:fiteats/src/presentation/blocs/workout_plan/workout_plan_event.dart';
import 'package:fiteats/src/presentation/blocs/workout_plan/workout_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutPlanBloc extends Bloc<WorkoutPlanEvent, WorkoutPlanState> {
  WorkoutPlanBloc(
    this._getWorkoutPlanByDateUseCase,
    this._saveWorkoutPlanUseCase,
    this._toggleWorkoutCompletionUseCase,
  ) : super(const WorkoutPlanState.initial()) {
    on<LoadWorkoutPlanByDateEvent>(_onLoadWorkoutPlanByDate);
    on<SaveWorkoutPlanEvent>(_onSaveWorkoutPlan);
    on<ToggleCompletionEvent>(_onToggleCompletion);
    on<GenerateWorkoutPlanEvent>(_onGenerateWorkoutPlan);
  }

  final GetWorkoutPlanByDateUseCase _getWorkoutPlanByDateUseCase;
  final SaveWorkoutPlanUseCase _saveWorkoutPlanUseCase;
  final ToggleWorkoutCompletionUseCase _toggleWorkoutCompletionUseCase;

  Future<void> _onLoadWorkoutPlanByDate(
    LoadWorkoutPlanByDateEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(const WorkoutPlanState.loading());

    final result = await _getWorkoutPlanByDateUseCase(event.date);

    result.fold(
      (failure) => emit(WorkoutPlanState.error(failure.userMessage)),
      (workoutPlan) => emit(WorkoutPlanState.loaded(workoutPlan)),
    );
  }

  Future<void> _onSaveWorkoutPlan(
    SaveWorkoutPlanEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(const WorkoutPlanState.saving());

    final result = await _saveWorkoutPlanUseCase(event.workoutPlan);

    result.fold(
      (failure) => emit(WorkoutPlanState.error(failure.userMessage)),
      (_) => emit(const WorkoutPlanState.saved()),
    );
  }

  Future<void> _onToggleCompletion(
    ToggleCompletionEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    final result = await _toggleWorkoutCompletionUseCase(event.workoutPlanId);

    result.fold(
      (failure) => emit(WorkoutPlanState.error(failure.userMessage)),
      (_) {
        // Reload workout plan after toggling completion
        // Note: We'd need the date to reload, so in a real app we'd store it
        // For now, just emit saved state
        emit(const WorkoutPlanState.saved());
      },
    );
  }

  Future<void> _onGenerateWorkoutPlan(
    GenerateWorkoutPlanEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(const WorkoutPlanState.generating());

    // TODO: Implement AI workout plan generation
    // This will be implemented in Phase 5
    emit(
      const WorkoutPlanState.error(
        'AI workout plan generation is not yet implemented',
      ),
    );
  }
}
