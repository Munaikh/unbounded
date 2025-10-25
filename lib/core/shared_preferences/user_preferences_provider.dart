import 'dart:convert';

import 'package:apparence_kit/core/shared_preferences/models/user_preferences.dart';
import 'package:apparence_kit/core/shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_preferences_provider.g.dart';

const String _kUserPreferencesKey = 'user_preferences';

@Riverpod(keepAlive: true)
class UserPreferencesNotifier extends _$UserPreferencesNotifier {
  @override
  UserPreferences build() {
    final prefs = ref.read(sharedPreferencesProvider).prefs;
    final json = prefs.getString(_kUserPreferencesKey);
    if (json == null) {
      return const UserPreferences();
    }
    try {
      return UserPreferences.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return const UserPreferences();
    }
  }

  Future<void> setPreferences(UserPreferences preferences) async {
    final prefs = ref.read(sharedPreferencesProvider).prefs;
    await prefs.setString(_kUserPreferencesKey, jsonEncode(preferences.toJson()));
    state = preferences;
  }

  Future<void> clearPreferences() async {
    final prefs = ref.read(sharedPreferencesProvider).prefs;
    await prefs.remove(_kUserPreferencesKey);
    state = const UserPreferences();
  }
}
