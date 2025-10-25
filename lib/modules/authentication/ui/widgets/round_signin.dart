import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef SocialSigninCallback = void Function();

class SocialSigninButton extends StatelessWidget {
  final Image iconImage;
  final SocialSigninCallback? onPressed;

  const SocialSigninButton({
    super.key,
    required this.iconImage,
    required this.onPressed,
  });

  factory SocialSigninButton.google(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/google.png", width: 24),
      onPressed: onPressed,
    );
  }

  factory SocialSigninButton.googlePlayGames(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/google_play_games.png", width: 24),
      onPressed: onPressed,
    );
  }

  factory SocialSigninButton.facebook(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/facebook.png", width: 24),
      onPressed: onPressed,
    );
  }

  factory SocialSigninButton.apple(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/apple.png", width: 24),
      onPressed: onPressed,
    );
  }

  factory SocialSigninButton.twitter(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/twitter.png", width: 24),
      onPressed: onPressed,
    );
  }

  factory SocialSigninButton.microsoft(SocialSigninCallback onPressed) {
    return SocialSigninButton(
      iconImage: Image.asset("assets/icons/microsoft.png", width: 24),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        shape: BoxShape.circle,
      ),
      child: RawMaterialButton(
        elevation: 0,
        onPressed: () {
          HapticFeedback.mediumImpact();
          onPressed?.call();
        },
        shape: const CircleBorder(),
        fillColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: iconImage,
      ),
    );
  }
}
