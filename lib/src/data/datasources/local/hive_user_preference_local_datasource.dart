import 'package:fiteats/src/data/models/user_preference_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveUserPreferenceLocalDataSource {
  Future<void> saveUserPreference(UserPreferenceModel preference);
  Future<UserPreferenceModel?> getUserPreference(String userId);
  Future<void> deleteUserPreference(String userId);
  Future<List<UserPreferenceModel>> getAllUserPreferences();
}

@LazySingleton(as: HiveUserPreferenceLocalDataSource)
class HiveUserPreferenceLocalDataSourceImpl
    implements HiveUserPreferenceLocalDataSource {
  HiveUserPreferenceLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;
  static const String _keyPrefix = 'user_preference_';

  String _getUserKey(String userId) => '$_keyPrefix$userId';

  @override
  Future<void> saveUserPreference(UserPreferenceModel preference) async {
    final key = _getUserKey(preference.userId);
    await _box.put(key, preference.toJson());
  }

  @override
  Future<UserPreferenceModel?> getUserPreference(String userId) async {
    final key = _getUserKey(userId);
    final data = _box.get(key);
    if (data == null) return null;

    return UserPreferenceModel.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
  }

  @override
  Future<void> deleteUserPreference(String userId) async {
    final key = _getUserKey(userId);
    await _box.delete(key);
  }

  @override
  Future<List<UserPreferenceModel>> getAllUserPreferences() async {
    final allKeys = _box.keys.where((key) => key.toString().startsWith(_keyPrefix));
    final preferences = <UserPreferenceModel>[];

    for (final key in allKeys) {
      final data = _box.get(key);
      if (data != null) {
        preferences.add(
          UserPreferenceModel.fromJson(
            Map<String, dynamic>.from(data as Map),
          ),
        );
      }
    }

    return preferences;
  }
}
