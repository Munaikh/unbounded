class OnboardingState {
  DateTime? reminder;

  OnboardingState({
    this.reminder,
  });

  OnboardingState copyWith({
    DateTime? reminder,
  }) {
    return OnboardingState(
      reminder: reminder ?? this.reminder,
    );
  }
}
