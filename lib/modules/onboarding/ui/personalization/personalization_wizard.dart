import 'package:apparence_kit/core/shared_preferences/models/user_preferences.dart';
import 'package:apparence_kit/core/shared_preferences/user_preferences_provider.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/activities/entity/tag_entity.dart';
import 'package:apparence_kit/modules/activities/providers/all_tags_provider.dart';
import 'package:apparence_kit/modules/activities/providers/filtered_activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PersonalizationWizard extends ConsumerStatefulWidget {
  const PersonalizationWizard({super.key});

  @override
  ConsumerState<PersonalizationWizard> createState() => _PersonalizationWizardState();
}

class _PersonalizationWizardState extends ConsumerState<PersonalizationWizard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  int? _minPeople;
  int? _maxPeople;
  double _budgetPerPerson = 25.0;
  String? _activityType;
  bool _surpriseMe = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _skip() {
    context.pop();
  }

  Future<void> _finish() async {
    // Save preferences to shared preferences
    final preferences = UserPreferences(
      minPeople: _minPeople,
      maxPeople: _maxPeople,
      budgetPerPerson: _budgetPerPerson,
      activityType: _activityType,
      surpriseMe: _surpriseMe,
    );

    await ref.read(userPreferencesProvider.notifier).setPreferences(preferences);

    // Refresh the filtered activities provider to apply new filters
    ref.invalidate(filteredActivitiesProvider);

    // Show confirmation message
    final selections = <String>[];
    if (_minPeople != null && _maxPeople != null) {
      selections.add('Group: $_minPeople-$_maxPeople people');
    }
    selections.add('Budget: £${_budgetPerPerson.toInt()} per person');
    if (_surpriseMe) {
      selections.add('Surprise me!');
    } else if (_activityType != null) {
      selections.add('Type: $_activityType');
    }

    if (mounted && context.mounted) {
      // Pop first, then show toast
      context.pop();

      // Show toast after a short delay to ensure the navigation completes
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          ref
              .read(toastProvider)
              .success(
                title: 'Preferences saved',
                text: 'Preferences saved: ${selections.join(', ')}',
              );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagsAsync = ref.watch(allTagsProvider);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: tagsAsync.when(
          data: (tags) {
            final activityTypeTags = _getActivityTypeTags(tags);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: _buildProgressIndicator(),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildGroupSizePage(),
                      _buildBudgetPage(),
                      _buildActivityTypePage(activityTypeTags),
                    ],
                  ),
                ),
                _buildBottomButtons(),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Error loading tags: $error',
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TagEntity> _getActivityTypeTags(List<TagEntity> allTags) {
    // Define the primary activity types we want to show
    final primaryTypes = ['Arcade', 'Food', 'Karaoke', 'Puzzle', 'Sport', 'Other'];

    return allTags.where((tag) => primaryTypes.contains(tag.name)).toList()..sort((a, b) {
      // Sort by the order in primaryTypes list
      final aIndex = primaryTypes.indexOf(a.name);
      final bIndex = primaryTypes.indexOf(b.name);
      return aIndex.compareTo(bIndex);
    });
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index == _currentPage;
        final isCompleted = index < _currentPage;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(left: index > 0 ? 8 : 0),
            height: 4,
            decoration: ShapeDecoration(
              color: isCompleted || isActive
                  ? context.colors.primary
                  : context.colors.onBackground.withValues(alpha: 0.2),
              shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(2)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildGroupSizePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'How many people are going? 🚶',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a range (you can adjust later)',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(child: _buildGroupSizeOption('2 - 6', 2, 6)),
              const SizedBox(width: 12),
              Expanded(child: _buildGroupSizeOption('5 - 8', 5, 8)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildGroupSizeOption('9 - 15', 9, 15)),
              const SizedBox(width: 12),
              Expanded(child: _buildGroupSizeOption('16+', 16, 100)),
            ],
          ),
          const Spacer(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGroupSizeOption(String label, int min, int max) {
    final isSelected = _minPeople == min && _maxPeople == max;
    return GestureDetector(
      onTap: () {
        setState(() {
          _minPeople = min;
          _maxPeople = max;
        });
      },
      child: PressableScale(
        child: Container(
          height: 80,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.onBackground.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? context.colors.primary : context.colors.onBackground,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Whats the budget per person?💷',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll priorities good value",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 80),
          Center(
            child: Text(
              '£${_budgetPerPerson.toInt() == 100 ? '100+' : _budgetPerPerson.toInt()}',
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(height: 40),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: context.colors.primary,
              inactiveTrackColor: context.colors.onBackground.withValues(alpha: 0.2),
              thumbColor: context.colors.primary,
              overlayColor: context.colors.primary.withValues(alpha: 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: _budgetPerPerson,
              max: 100,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  _budgetPerPerson = value;
                });
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildActivityTypePage(List<TagEntity> activityTypeTags) {
    // Map tag names to emojis
    final tagEmojis = {
      'Arcade': '🎮',
      'Food': '🍕',
      'Karaoke': '🎵',
      'Puzzle': '🧩',
      'Sport': '🏈',
      'Other': '➡️',
    };

    // Split tags into rows of 3
    final rows = <List<TagEntity>>[];
    for (var i = 0; i < activityTypeTags.length; i += 3) {
      final end = (i + 3 < activityTypeTags.length) ? i + 3 : activityTypeTags.length;
      rows.add(activityTypeTags.sublist(i, end));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'What are you feeling?😊',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'You can change this later',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 48),
          ...rows.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  for (var i = 0; i < row.length; i++) ...[
                    if (i > 0) const SizedBox(width: 12),
                    Expanded(
                      child: _buildActivityTypeOption(tagEmojis[row[i].name] ?? '🎯', row[i].name),
                    ),
                  ],
                  // Add empty spaces if the row has fewer than 3 items
                  for (var i = row.length; i < 3; i++) ...[
                    const SizedBox(width: 12),
                    const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _surpriseMe = !_surpriseMe;
                if (_surpriseMe) {
                  _activityType = null;
                }
              });
            },
            child: PressableScale(
              child: Container(
                height: 60,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: _surpriseMe
                          ? context.colors.primary
                          : context.colors.onBackground.withValues(alpha: 0.2),
                      width: _surpriseMe ? 2 : 1,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🎲 ', style: context.textTheme.titleLarge),
                    Text(
                      'Surprise me',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: _surpriseMe ? FontWeight.w600 : FontWeight.w400,
                        color: _surpriseMe ? context.colors.primary : context.colors.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildActivityTypeOption(String emoji, String label) {
    final isSelected = _activityType == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activityType = label;
          _surpriseMe = false;
        });
      },
      child: PressableScale(
        child: Container(
          height: 100,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.onBackground.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? context.colors.primary : context.colors.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _nextPage,
            child: PressableScale(
              child: Container(
                height: 60,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(28)),
                  color: context.colors.primary,
                ),
                alignment: Alignment.center,
                child: Text(
                  _currentPage < 2 ? 'Continue' : 'Continue',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _skip,
            child: Text(
              'Skip',
              style: context.textTheme.titleMedium?.copyWith(color: context.colors.onBackground),
            ),
          ),
        ],
      ),
    );
  }
}
