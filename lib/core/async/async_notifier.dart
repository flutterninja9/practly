import 'package:flutter/material.dart';
import 'package:practly/core/enums/enums.dart';
import 'async_value.dart';

class AsyncNotifier<T> extends ChangeNotifier {
  AsyncValue<T> _state = const AsyncValue.loading();

  AsyncValue<T> get state => _state;

  WordComplexity _complexity = WordComplexity.easy;

  WordComplexity get complexity => _complexity;

  void setLoading() {
    _state = const AsyncValue.loading();
    notifyListeners();
  }

  void setComplexity(WordComplexity newComplexity) {
    _complexity = newComplexity;
    notifyListeners();
  }

  void setData(T data) {
    if (data == null || (data is List && (data as List).isEmpty)) {
      _state = const AsyncValue.error("No Data Available");
    } else {
      _state = AsyncValue.data(data);
    }
    notifyListeners();
  }

  void setError(Object error) {
    _state = AsyncValue.error(error);
    notifyListeners();
  }

  Future<void> execute(Future<T> Function() operation) async {
    try {
      setLoading();
      final result = await operation();
      setData(result);
    } catch (error) {
      setError(error);
    }
  }
}
