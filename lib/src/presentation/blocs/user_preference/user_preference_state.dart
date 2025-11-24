import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preference_state.freezed.dart';

@freezed
class UserPreferenceState with _$UserPreferenceState {
  const factory UserPreferenceState.initial() = UserPreferenceInitial;

  const factory UserPreferenceState.loading() = UserPreferenceLoading;

  const factory UserPreferenceState.loaded(UserPreference preference) =
      UserPreferenceLoaded;

  const factory UserPreferenceState.saving() = UserPreferenceSaving;

  const factory UserPreferenceState.saved() = UserPreferenceSaved;

  const factory UserPreferenceState.error(String message) =
      UserPreferenceError;
}
