
import 'dart:async';
import 'dart:math';

import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/data/repositories/user_repository.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/settings/ui/widgets/round_progress.dart';
import 'package:apparence_kit/modules/settings/ui/widgets/user_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';


/// A widget that displays the user avatar
/// and allow to change it by tapping on it
/// It displays a progress indicator while uploading
/// (the progress indicator will won't show if the upload is too fast)
/// and a scale animation when upload is completed
class EditableUserAvatar extends ConsumerStatefulWidget {
  final OnAvatarTap? onTap;
  final double? radius;

  const EditableUserAvatar({
    super.key,
    this.onTap,
    this.radius,
  });

  @override
  ConsumerState<EditableUserAvatar> createState() => _EditableUserAvatarState();
}

class _EditableUserAvatarState extends ConsumerState<EditableUserAvatar> {
  XFile? temporaryAvatarFile;
  StreamSubscription<UploadResult>? _saveAvatarSubscription;
  double uploadProgress = 0;

  @override
  void dispose() {
    super.dispose();
    _saveAvatarSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateNotifierProvider);

    return Stack(
      children: [
        if (isUploading)
          Positioned.fill(
            child: RoundProgress(
              color: Theme.of(context).primaryColor.withValues(alpha: .6),
              radius: 50,
              progress: uploadProgress,
            ),
          ),
        UploadedAvatarAnimation(
          userAvatar: UserAvatar(
            radius: widget.radius,
            file: !kIsWeb && temporaryAvatarFile != null
                ? File(temporaryAvatarFile!.path)
                : null,
            avatarUrl: switch (userState.user) {
              AuthenticatedUserData(:final avatarPath) => avatarPath,
              _ => null,
            },
            onTap: () => onTapAvatar(userState),
          ),
          isUploading: isUploading,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: .6),
                width: 4,
              ),
            ),
            child: const Center(
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        )
      ],
    );
  }

  bool get isUploading => _saveAvatarSubscription != null;

  Future<void> onTapAvatar(UserState userState) async {
    final picker = ImagePicker();
    picker //
        .pickImage(source: ImageSource.gallery)
        .then((file) => uploadTask(file, userState));
  }

  Future<void> uploadTask(XFile? file, UserState userState) async {
    setState(() {
      temporaryAvatarFile = file;
    });
    if (file == null) {
      return;
    }
    final bytes = await file.readAsBytes();
    _saveAvatarSubscription = ref
        .read(userRepositoryProvider) //
        .saveAvatar(
          userId: userState.user.idOrThrow,
          data: bytes,
        )
        .listen((event) async {
      switch (event) {
        case UploadResultProgress():
          setState(() {
            uploadProgress = event.progress;
          });
        case UploadResultCompleted():
          uploadProgress = 0;
          _saveAvatarSubscription!.cancel();
          _saveAvatarSubscription = null;
          ref.read(userStateNotifierProvider.notifier).onUpdateAvatar();
          setState(() {});
      }
    });
  }
}

/// A widget that displays the user avatar with a fade animation
/// Once upload is completed, the avatar is displayed with a scale animation and opacity = 1
class UploadedAvatarAnimation extends StatefulWidget {
  final UserAvatar userAvatar;
  final bool isUploading;

  const UploadedAvatarAnimation({
    super.key,
    required this.userAvatar,
    this.isUploading = false,
  });

  @override
  State<UploadedAvatarAnimation> createState() =>
      _UploadedAvatarAnimationState();
}

class _UploadedAvatarAnimationState extends State<UploadedAvatarAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _initOpacityAnim(1, 0.6);
    _initScaleAnim(0, 0);
  }

  @override
  void didUpdateWidget(covariant UploadedAvatarAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final (wasUploading, isUploading) =
        (oldWidget.isUploading, widget.isUploading);
    switch ((wasUploading, isUploading)) {
      case (false, true):
        _controller.forward(from: 0);
      case (true, false):
        _initScaleAnim(0, pi);
        _controller.reverse(from: 1);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnim,
      builder: (context, child) => Opacity(
        opacity: _opacityAnim.value,
        child: Transform.scale(
          // change the 0.4 for larger or smaller animation
          scale: 1.0 + sin(_scaleAnim.value) * 0.4,
          child: widget.userAvatar,
        ),
      ),
    );
  }

  void _initOpacityAnim(double begin, double end) {
    _opacityAnim = Tween(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
  }

  void _initScaleAnim(double begin, double end) {
    _scaleAnim = Tween(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
  }
}

