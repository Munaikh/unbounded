import 'package:apparence_kit/core/shared_preferences/user_preferences_provider.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:apparence_kit/modules/activities/providers/all_activities_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_activities_provider.g.dart';

@riverpod
Future<List<ActivityEntity>> filteredActivities(Ref ref) async {
  final allActivities = await ref.watch(allActivitiesProvider.future);
  final preferences = ref.watch(userPreferencesProvider);

  Logger().i('🔍 Filtering with preferences: ${preferences.toJson()}');
  Logger().i('🔍 Has preferences: ${preferences.hasPreferences}');

  // If no preferences are set, return all activities
  if (!preferences.hasPreferences) {
    Logger().i('🔍 No preferences set, returning all ${allActivities.length} activities');
    return allActivities;
  }

  // Get preferred tags based on user preferences
  final List<String> preferredTags = [];

  // Add activity type tag if not surprise me
  if (!preferences.surpriseMe && preferences.activityType != null) {
    preferredTags.add(preferences.activityType!);
  }

  // Add budget tag
  if (preferences.budgetPerPerson != null) {
    if (preferences.budgetPerPerson! <= 15) {
      preferredTags.add('Budget-Friendly');
    } else if (preferences.budgetPerPerson! <= 30) {
      preferredTags.add('Mid-Range');
    } else {
      preferredTags.add('Premium');
    }
  }

  // Add group size tag
  if (preferences.minPeople != null) {
    if (preferences.minPeople! <= 6) {
      preferredTags.add('Small Group');
    } else if (preferences.minPeople! <= 15) {
      preferredTags.add('Medium Group');
    } else {
      preferredTags.add('Large Group');
    }
  }

  Logger().i('🔍 Preferred tags: $preferredTags');

  // If surprise me or no specific tags, return all activities
  if (preferences.surpriseMe || preferredTags.isEmpty) {
    Logger().i('🔍 Surprise me or no tags, returning all ${allActivities.length} activities');
    return allActivities;
  }

  // Filter activities that match ALL preferred tags (stricter filtering)
  final filteredList = allActivities.where((activity) {
    final activityTagNames = activity.tags.map((tag) => tag.name).toList();
    // Check if activity has ALL the preferred tags
    final hasMatch = preferredTags.every((preferredTag) => activityTagNames.contains(preferredTag));
    Logger().i('🔍 Activity "${activity.name}" tags: $activityTagNames, matches ALL: $hasMatch');
    return hasMatch;
  }).toList();

  Logger().i(
    '🔍 Filtered ${filteredList.length} activities from ${allActivities.length} (strict: ALL tags must match)',
  );

  // If no activities match, return all activities (fallback)
  if (filteredList.isEmpty) {
    Logger().w('🔍 No activities matched ALL filters, returning all activities as fallback');
    return allActivities;
  }

  return filteredList;
}
