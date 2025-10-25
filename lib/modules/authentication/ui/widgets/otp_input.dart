import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that allows the user to input an OTP.
///
/// This widget is a wrapper around the [OtpInputField] widget.
/// It manages the focus and text input of the individual input fields.
/// It also provides a main controller to listen to the changes of the OTP.
class OtpInput extends StatefulWidget {
  /// The callback that is called when the OTP is completed.
  final Function(String) onCompleted;

  /// The length of the OTP.
  final int length;

  /// The main controller to listen to the changes of the OTP.
  final TextEditingController? controller;

  const OtpInput({
    super.key,
    required this.onCompleted,
    this.length = 6,
    this.controller,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );

    if (widget.controller != null) {
      widget.controller!.addListener(_handleExternalControllerChange);
    }
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }

    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void _handleExternalControllerChange() {
    if (widget.controller != null) {
      final text = widget.controller!.text;

      for (int i = 0; i < widget.length; i++) {
        if (i < text.length) {
          _controllers[i].text = text[i];
        } else {
          _controllers[i].text = '';
        }
      }
    }
  }

  String _getOtpValue() {
    return _controllers.map((controller) => controller.text).join();
  }

  void _checkCompletion() {
    final otp = _getOtpValue();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => Expanded(
          child: OtpInputField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            onChanged: (value) {
              if (widget.controller != null) {
                final currentOtp = _getOtpValue();
                widget.controller!.text = currentOtp;
              }
              if (index < widget.length - 1) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else {
                FocusScope.of(context).unfocus();
                _checkCompletion();
              }
            },
            onDelete: () {
              if (index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        ),
      ),
    );
  }
}

typedef OtpInputFieldChanged = void Function(String value);

typedef OtpInputFieldDelete = void Function();

/// A single input field for the OTP input.
class OtpInputField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode focusNode;
  final OtpInputFieldChanged onChanged;
  final OtpInputFieldDelete onDelete;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            onChanged(value);
            return;
          }
          if (value.isEmpty) {
            onDelete();
            return;
          }
        },
        onTap: () {
          controller!.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller!.text.length,
          );
        },
      ),
    );
  }
}
