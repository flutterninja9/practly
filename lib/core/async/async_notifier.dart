import 'package:flutter/material.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'async_value.dart';

class AsyncNotifier<T> extends ChangeNotifier {
  final DatabaseService _databaseService;
  final AdService _adService;

  AsyncValue<T> _state = const AsyncValue.loading();

  AsyncValue<T> get state => _state;

  WordComplexity _complexity = WordComplexity.easy;

  AsyncNotifier(this._databaseService, this._adService);

  WordComplexity get complexity => _complexity;

  void setLoading() {
    _state = const AsyncValue.loading();
    notifyListeners();
  }

  void setOutOfCredits() {
    _state = const AsyncValue.outOfCredits();
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
      if (await _databaseService.getGenerationLimit() <= 0) {
        setOutOfCredits();
      } else {
        setLoading();
        final result = await operation();
        await _databaseService.decrementGenerationLimit();
        setData(result);
      }
    } catch (error) {
      setError(error);
    }
  }
}
