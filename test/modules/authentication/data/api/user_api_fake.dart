import 'dart:typed_data';

import 'package:apparence_kit/core/data/api/storage_api.dart';
import 'package:apparence_kit/core/data/api/user_api.dart';
import 'package:apparence_kit/core/data/entities/upload_result.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';

class FakeUserApi implements UserApi {
  final StorageApi storageApi;
  UserEntity? getUserResult;

  FakeUserApi({
    required this.storageApi,
  });

  @override
  Future<UserEntity> get(String id) async {
    if (id == 'fake-user-id-anonymous') {
      return UserEntity(
        id: id,
        creationDate: DateTime.now(),
        lastUpdateDate: DateTime.now(),
      );
    }
    return getUserResult ??
        UserEntity(
          id: 'userid',
          name: 'Mac Gyver',
          email: 'mac@gyver.com',
          avatarPath: 'https://avatar.com/macgyver.png',
          creationDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
        );
  }

  @override
  Future<void> create(UserEntity user) async {
    getUserResult = user;
  }

  @override
  Future<void> delete(String id) {
    return Future.value();
  }

  @override
  Future<void> deleteMe() {
    return Future.value();
  }

  @override
  Future<void> update(UserEntity user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<UploadResult> updateAvatar(String userId, Uint8List data) async* {
    final task = storageApi.uploadData(
      data,
      'users/$userId/avatar',
      'thumb.jpg',
      mimeType: 'image/jpg',
    );

    late UploadResult lastRes;
    await for (final res in task) {
      yield res;
      lastRes = res;
    }
    if (lastRes case UploadResultCompleted()) {
      return;
    } else {
      throw Exception('Upload failed');
    }
  }
}
