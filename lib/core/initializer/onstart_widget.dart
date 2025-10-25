import 'package:apparence_kit/core/initializer/models/run_state.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

typedef OnInitErrorBuilder =
    Widget Function(BuildContext context, String error);

class Initializer extends ConsumerStatefulWidget {
  final Widget onReady;
  final Widget onLoading;
  final OnInitErrorBuilder? onError;
  final List<ProviderListenable<OnStartService>> services;

  const Initializer({
    super.key,
    required this.onReady,
    required this.onLoading,
    this.onError,
    this.services = const [],
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitializerState();
}

class _InitializerState extends ConsumerState<Initializer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(onStartProvider.notifier).init(widget.services);
    });
  }

  @override
  Widget build(BuildContext context) {
    final onStartState = ref.watch(onStartProvider);

    return switch (onStartState) {
      AppLoadingState() => widget.onLoading,
      AppReadyState() => widget.onReady,
      AppErrorState(:final error) =>
        widget.onError?.call(context, error) ??
            const Center(child: Text('An error occured')),
    };
  }
}
