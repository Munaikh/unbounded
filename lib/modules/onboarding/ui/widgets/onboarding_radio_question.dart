import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/modules/onboarding/ui/animations/movefade_anim.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_progress.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/selectable_row_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OptionBuilder = Widget Function(String key, bool selected);

typedef ReassuranceBuilder = Widget? Function(String key);

typedef OnOptionIdSelected = void Function(String id);

typedef OnValidate = void Function(String? key);

/// Single choice question with radio buttons
class OnboardingRadioQuestion extends ConsumerStatefulWidget {
  final double? progress;
  final String title;
  final String description;
  final String btnText;
  final List<String> optionIds;
  final OptionBuilder optionBuilder;
  final ReassuranceBuilder? reassuranceBuilder;
  final OnOptionIdSelected? onOptionIdSelected;
  final OnValidate? onValidate;

  const OnboardingRadioQuestion({
    super.key,
    required this.title,
    required this.description,
    required this.btnText,
    required this.optionIds,
    required this.optionBuilder,
    this.progress,
    this.onOptionIdSelected,
    this.onValidate,
    this.reassuranceBuilder,
  });

  @override
  ConsumerState<OnboardingRadioQuestion> createState() =>
      _OnboardingRadioQuestionState();
}

class _OnboardingRadioQuestionState
    extends ConsumerState<OnboardingRadioQuestion> {
  String? selectedChoiceId;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        if (widget.progress != null)
          OnboardingProgress(value: widget.progress!),
        Flexible(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: MoveFadeAnim(
              delayInMs: 100,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: MoveFadeAnim(
              delayInMs: 200,
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: OnboardingSelectableRowGroup(
              physics: const NeverScrollableScrollPhysics(),
              options: widget.optionIds //
                  .map(
                (e) {
                  final index = widget.optionIds.indexOf(e);
                  return Animate(
                    effects: [
                      FadeEffect(
                        delay: Duration(milliseconds: 300 + index * 100),
                        duration: const Duration(milliseconds: 550),
                        curve: Curves.easeInOut,
                      ),
                    ],
                    child: widget.optionBuilder(e, e == selectedChoiceId),
                  );
                },
              ).toList(),
              onSelect: (index, selected) {
                widget.onOptionIdSelected?.call(widget.optionIds[index]);
                SystemSound.play(SystemSoundType.click);
                setState(() {
                  selectedChoiceId = widget.optionIds[index];
                });
              },
              onSelectInfoWidget: widget.optionIds
                  .map((el) => widget.reassuranceBuilder?.call(el))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 200),
      ],
    );

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.colors.primary.withValues(alpha: .15),
                  context.colors.primary.withValues(alpha: 0),
                ],
                stops: const [0.0, .5],
              ),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              small: content,
              medium: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: content,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: defaultTargetPlatform == TargetPlatform.android ? 16 : 0,
          left: 0,
          right: 0,
          child: DeviceSizeBuilder(
            builder: (device) => SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: switch (device) {
                    DeviceType.small => const BoxConstraints(
                        minWidth: double.infinity,
                      ),
                    _ => const BoxConstraints(minWidth: 600, maxWidth: 600),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.background,
                      gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [
                          context.colors.background,
                          context.colors.background.withValues(alpha: .1),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24.0, 56, 24, 16),
                    child: MoveFadeAnim(
                      delayInMs: 500,
                      child: ElevatedButton(
                        onPressed: selectedChoiceId == null
                            ? null
                            : () {
                                widget.onValidate?.call(selectedChoiceId);
                              },
                        child: Text(widget.btnText),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
