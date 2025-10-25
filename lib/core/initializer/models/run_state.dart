import 'package:freezed_annotation/freezed_annotation.dart';

part 'run_state.freezed.dart';

@freezed
sealed class AppRunState with _$AppRunState {
  const factory AppRunState.loading() = AppLoadingState;

  const factory AppRunState.ready() = AppReadyState;

  const factory AppRunState.error(String error) = AppErrorState;

  const AppRunState._();
}
