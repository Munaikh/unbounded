import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/modules/authentication/providers/models/phone_signin_state.dart';
import 'package:apparence_kit/modules/authentication/providers/phone_auth_notifier.dart';
import 'package:apparence_kit/modules/authentication/ui/components/otp_verification.dart';
import 'package:apparence_kit/modules/authentication/ui/components/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneAuthPage extends ConsumerStatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  ConsumerState<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends ConsumerState<PhoneAuthPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneAuthProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          title: switch (state) {
            PhoneAuthInputPhoneState() => const Text('Phone Authentication'),
            PhoneAuthVerifyOtpState() => const Text('Verify OTP'),
          },
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: switch (state) {
            PhoneAuthInputPhoneState() => true,
            PhoneAuthVerifyOtpState() => false,
          },
          leading: switch (state) {
            PhoneAuthVerifyOtpState() => IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(phoneAuthProvider.notifier).reset();
                },
              ),
            _ => null,
          },
        ),
        body: SafeArea(
          child: LargeLayoutContainer(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: switch (state) {
                  PhoneAuthInputPhoneState() => const PhoneInputComponent(),
                  PhoneAuthVerifyOtpState() => const OtpVerificationComponent(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
