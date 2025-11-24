import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preference_event.freezed.dart';

@freezed
class UserPreferenceEvent with _$UserPreferenceEvent {
  const factory UserPreferenceEvent.loadUserPreference(String userId) =
      LoadUserPreferenceEvent;

  const factory UserPreferenceEvent.saveUserPreference(
    UserPreference preference,
  ) = SaveUserPreferenceEvent;

  const factory UserPreferenceEvent.updateUserPreference(
    UserPreference preference,
  ) = UpdateUserPreferenceEvent;
}
