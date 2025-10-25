import 'package:apparence_kit/core/initializer/models/run_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onstart_service.g.dart';

abstract class OnStartService {
  Future<void> init();
}

@Riverpod(keepAlive: true)
class OnStartNotifier extends _$OnStartNotifier {
  @override
  AppRunState build() {
    return const AppRunState.loading();
  }

  Future<void> init(List<ProviderListenable<OnStartService>> services) async {
    if (state is! AppLoadingState) {
      return;
    }
    try {
      for (final service in services) {
        final serviceInstance = ref.read(service);
        debugPrint(' - ${service.runtimeType} starting');
        await serviceInstance.init();
        debugPrint(' ✅ ${service.runtimeType} started');
      }
      onEnded();
    } catch (e) {
      notifyError(e.toString());
    }
  }

  void onEnded() {
    state = const AppRunState.ready();
    debugPrint('✅ All initialization services started');
  }

  void notifyError(String error) {
    state = AppRunState.error(error);
  }
}
