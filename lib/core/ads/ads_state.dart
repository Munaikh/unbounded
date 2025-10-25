import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_state.freezed.dart';

@freezed
sealed class AdState with _$AdState {
  const factory AdState({
    DateTime? lastAdShown,
  }) = _AdState;

  const AdState._();

  Duration get timeSinceLastAd =>
      DateTime.now().difference(lastAdShown ?? DateTime.now());
}
