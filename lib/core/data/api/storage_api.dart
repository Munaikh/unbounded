import 'dart:async';
import 'dart:typed_data';

import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final storageApiProvider = Provider<StorageApi>(
  (ref) => SupabaseStorageApi(
    client: Supabase.instance.client,
    storageBucket: 'apparencekit', // TODO : replace with your storage bucket
  ),
);

class StorageApi {
  StorageApi();

  /// upload a file to firebase storage
  /// and return a stream of the upload progress
  Stream<UploadResult> uploadData(
    Uint8List data,
    String folder,
    String filename, {
    String? mimeType, // ex 'image/jpg'
    bool isPublic = true,
  }) async* {
    throw UnimplementedError();
  }

  Future<void> deleteFile(String? imagePath) async {
    throw UnimplementedError();
  }
}

class SupabaseStorageApi implements StorageApi {
  final SupabaseClient _client;
  final String _storageBucket;

  SupabaseStorageApi({
    required SupabaseClient client,
    required String storageBucket,
  })  : _client = client,
        _storageBucket = storageBucket;

  @override
  Future<void> deleteFile(String? imagePath) {
    if (imagePath == null) {
      return Future.value();
    }
    return _client.storage.from(_storageBucket).remove([imagePath]);
  }

  @override
  Stream<UploadResult> uploadData(
    Uint8List data,
    String folder,
    String filename, {
    String? mimeType,
    bool isPublic = true,
  }) async* {
    final path = '$folder/$filename';
    yield UploadResultProgress(0);
    final result = await _client.storage.from(_storageBucket).uploadBinary(
          path,
          data,
          retryAttempts: 3,
          fileOptions: FileOptions(contentType: mimeType, upsert: true),
        );
    if (!isPublic) {
      yield UploadResultCompleted(
        imagePath: result,
        imagePublicUrl: '',
      );
    }
    // wait a bit to be sure the file is uploaded (could fire error if too fast)
    await Future.delayed(const Duration(seconds: 1));
    final publicUrl = await _client.storage
        .from(_storageBucket) //
        .createSignedUrl(path, 0);
    yield UploadResultCompleted(
      imagePath: result,
      imagePublicUrl: publicUrl,
    );
  }
}
