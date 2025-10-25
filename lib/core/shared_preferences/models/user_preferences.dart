import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    int? minPeople,
    int? maxPeople,
    double? budgetPerPerson,
    String? activityType,
    bool? surpriseMe,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  const UserPreferences._();

  bool get hasPreferences =>
      minPeople != null ||
      maxPeople != null ||
      budgetPerPerson != null ||
      activityType != null;
}

