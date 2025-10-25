sealed class UploadResult {}

class UploadResultProgress extends UploadResult {
  final double progress;

  UploadResultProgress(
    this.progress,
  );

  @override
  String toString() => 'UploadResultProgress($progress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadResultProgress && other.progress == progress;
  }

  @override
  int get hashCode => progress.hashCode;
}

class UploadResultCompleted extends UploadResult {
  final String imagePath;
  final String imagePublicUrl;

  UploadResultCompleted({
    required this.imagePath,
    required this.imagePublicUrl,
  });

  @override
  String toString() =>
      'UploadResultCompleted(imagePath: $imagePath, imagePublicUrl: $imagePublicUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadResultCompleted &&
        other.imagePath == imagePath &&
        other.imagePublicUrl == imagePublicUrl;
  }

  @override
  int get hashCode => imagePath.hashCode ^ imagePublicUrl.hashCode;
}
