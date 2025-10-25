import 'package:freezed_annotation/freezed_annotation.dart';

part 'pageable.freezed.dart';

@freezed
sealed class Pageable<T> with _$Pageable<T> {
  const factory Pageable({
    required int page,
    required int pageSize,
    required List<T> data,
  }) = _Pageable<T>;
}
