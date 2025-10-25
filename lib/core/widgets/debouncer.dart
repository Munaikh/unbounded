import 'dart:async';
import 'dart:ui';

/// A class that helps to debounce a function call.
/// It will prevent the function to be called multiple times in a short period of time.
/// It will only call the function once the delay is passed.
/// ex :
/// ```dart
/// final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
/// debouncer.run(() => repository.update(test));
/// ```
/// If that functions is called everytime the user types a letter, it will only be called once the user stops typing for 500ms.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}

/// A shortcut to debounce a function call.
void debounce({
  Duration duration = const Duration(milliseconds: 500),
  required VoidCallback action,
}) {
  return Debouncer(delay: duration).run(action);
}
