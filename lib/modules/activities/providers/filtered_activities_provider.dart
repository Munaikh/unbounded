import 'package:apparence_kit/core/shared_preferences/user_preferences_provider.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:apparence_kit/modules/activities/providers/all_activities_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_activities_provider.g.dart';

// Smart scoring system for AI-like recommendations
class _ActivityScore {
  final ActivityEntity activity;
  final double score;
  final List<String> matchReasons;

  _ActivityScore(this.activity, this.score, this.matchReasons);
}

@riverpod
Future<List<ActivityEntity>> filteredActivities(Ref ref) async {
  final allActivities = await ref.watch(allActivitiesProvider.future);
  final preferences = ref.watch(userPreferencesProvider);

  Logger().i('🤖 AI Filtering with preferences: ${preferences.toJson()}');

  // If no preferences are set, return all activities
  if (!preferences.hasPreferences) {
    Logger().i(
      '🤖 No preferences set, returning all ${allActivities.length} activities',
    );
    return allActivities;
  }

  // If surprise me, shuffle and return
  if (preferences.surpriseMe) {
    Logger().i('🎲 Surprise mode: shuffling activities');
    final shuffled = List<ActivityEntity>.from(allActivities)..shuffle();
    return shuffled;
  }

  // Score each activity based on how well it matches preferences
  final scoredActivities = allActivities.map((activity) {
    double score = 0.0;
    final matchReasons = <String>[];
    final activityTagNames = activity.tags.map((tag) => tag.name).toList();

    // 1. Activity type match (40 points for exact, 20 for similar)
    if (preferences.activityType != null) {
      if (activityTagNames.contains(preferences.activityType)) {
        score += 40;
        matchReasons.add('Perfect match: ${preferences.activityType}');
      } else {
        // Check for similar categories
        final similar = _getSimilarCategories(preferences.activityType!);
        for (final sim in similar) {
          if (activityTagNames.contains(sim)) {
            score += 20;
            matchReasons.add('Similar to ${preferences.activityType}: $sim');
            break;
          }
        }
      }
    }

    // 2. Budget match (30 points for exact range, 15 for adjacent range)
    if (preferences.budgetPerPerson != null && activity.cost != null) {
      final budget = preferences.budgetPerPerson!;
      final cost = activity.cost!;

      if ((cost - budget).abs() <= 5) {
        score += 30;
        matchReasons.add('Perfect budget match');
      } else if ((cost - budget).abs() <= 15) {
        score += 15;
        matchReasons.add('Close to your budget');
      } else if (cost < budget) {
        score += 10;
        matchReasons.add('Under budget');
      }
    }

    // 3. Group size match (20 points for perfect fit, 10 for partial)
    if (preferences.minPeople != null && preferences.maxPeople != null) {
      final minPref = preferences.minPeople!;
      final maxPref = preferences.maxPeople!;
      final minAct = activity.minGroupSize ?? 1;
      final maxAct = activity.maxGroupSize ?? 100;

      // Perfect overlap
      if (minAct <= minPref && maxAct >= maxPref) {
        score += 20;
        matchReasons.add('Perfect for your group size');
      } else if (minAct <= maxPref && maxAct >= minPref) {
        // Partial overlap
        score += 10;
        matchReasons.add('Works for your group');
      }
    }

    // 4. Bonus for popular/highly-rated activities (10 points)
    final popularTags = ['Popular', 'Top-Rated', 'Trending'];
    if (activityTagNames.any((tag) => popularTags.contains(tag))) {
      score += 10;
      matchReasons.add('Highly recommended');
    }

    Logger().i('🤖 "${activity.name}": score=$score, reasons=$matchReasons');
    return _ActivityScore(activity, score, matchReasons);
  }).toList();

  // Sort by score (highest first)
  scoredActivities.sort((a, b) => b.score.compareTo(a.score));

  // Return activities with score > 0, or top 10 if none match well
  final goodMatches = scoredActivities.where((s) => s.score > 0).toList();

  if (goodMatches.isEmpty) {
    Logger().i('🤖 No good matches, showing top 10 alternatives');
    return scoredActivities.take(10).map((s) => s.activity).toList();
  }

  Logger().i('🤖 Found ${goodMatches.length} recommended activities');
  return goodMatches.map((s) => s.activity).toList();
}

// Helper function to find similar categories
List<String> _getSimilarCategories(String category) {
  final similarityMap = {
    'Sport': ['Arcade', 'Puzzle', 'Other'],
    'Arcade': ['Sport', 'Puzzle', 'Other'],
    'Food': ['Other'],
    'Karaoke': ['Other', 'Arcade'],
    'Puzzle': ['Arcade', 'Sport', 'Other'],
    'Other': ['Sport', 'Arcade', 'Puzzle', 'Food', 'Karaoke'],
  };
  return similarityMap[category] ?? [];
}
