import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/usecases/user_preference/get_user_preference_usecase.dart';
import 'package:fiteats/src/domain/usecases/user_preference/save_user_preference_usecase.dart';
import 'package:fiteats/src/presentation/blocs/user_preference/user_preference_event.dart';
import 'package:fiteats/src/presentation/blocs/user_preference/user_preference_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserPreferenceBloc
    extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  UserPreferenceBloc(
    this._getUserPreferenceUseCase,
    this._saveUserPreferenceUseCase,
  ) : super(const UserPreferenceState.initial()) {
    on<LoadUserPreferenceEvent>(_onLoadUserPreference);
    on<SaveUserPreferenceEvent>(_onSaveUserPreference);
    on<UpdateUserPreferenceEvent>(_onUpdateUserPreference);
  }

  final GetUserPreferenceUseCase _getUserPreferenceUseCase;
  final SaveUserPreferenceUseCase _saveUserPreferenceUseCase;

  Future<void> _onLoadUserPreference(
    LoadUserPreferenceEvent event,
    Emitter<UserPreferenceState> emit,
  ) async {
    emit(const UserPreferenceState.loading());

    final result = await _getUserPreferenceUseCase(event.userId);

    result.fold(
      (failure) => emit(UserPreferenceState.error(failure.userMessage)),
      (preference) => emit(UserPreferenceState.loaded(preference)),
    );
  }

  Future<void> _onSaveUserPreference(
    SaveUserPreferenceEvent event,
    Emitter<UserPreferenceState> emit,
  ) async {
    emit(const UserPreferenceState.saving());

    final result = await _saveUserPreferenceUseCase(event.preference);

    result.fold(
      (failure) => emit(UserPreferenceState.error(failure.userMessage)),
      (_) => emit(const UserPreferenceState.saved()),
    );
  }

  Future<void> _onUpdateUserPreference(
    UpdateUserPreferenceEvent event,
    Emitter<UserPreferenceState> emit,
  ) async {
    emit(const UserPreferenceState.saving());

    final result = await _saveUserPreferenceUseCase(event.preference);

    result.fold(
      (failure) => emit(UserPreferenceState.error(failure.userMessage)),
      (_) => emit(UserPreferenceState.loaded(event.preference)),
    );
  }
}
