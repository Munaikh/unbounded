import 'dart:async';

import 'package:flutter/material.dart';

typedef OnFieldChanged = Function(String value);

class AppFormField extends StatefulWidget {
  final Key? formKey;
  final OnFieldChanged? onChanged;
  final String? hintText;
  final String? labelText;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AppFormField({
    this.onChanged,
    this.hintText,
    this.labelText,
    this.formKey,
    this.validator,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  final _controller = TextEditingController();
  final debouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      controller: _controller,
      onChanged: (value) {
        debouncer.run(() {
          widget.onChanged?.call(value);
        });
        setState(() {});
      },
      validator: (value) => widget.validator?.call(value),
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
        labelText: widget.labelText ?? '',
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }
}

typedef DebounceAction = void Function();

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(DebounceAction action) {
    _timer?.cancel();
    _timer = Timer(delay, () => action());
  }
}
