import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_value.freezed.dart';

@freezed
class AsyncValue<T> with _$AsyncValue<T> {
  const factory AsyncValue.loading() = Loading<T>;
  const factory AsyncValue.data(T value) = Data<T>;
  const factory AsyncValue.empty() = Empty<T>;
  const factory AsyncValue.error(Object error) = Error<T>;
}
