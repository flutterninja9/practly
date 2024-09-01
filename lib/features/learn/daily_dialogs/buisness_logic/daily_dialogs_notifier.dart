import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/features/learn/data/daily_dialogs_model.dart';
import 'package:practly/features/learn/data/learn_repository.dart';

class DailyDialogsNotifier extends AsyncNotifier<List<DailyDialogModel>> {
  final LearnRepository _repository;
  final DatabaseService _databaseService;
  final AdService _adService;

  DailyDialogsNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> getDailyDialogs() async {
    execute(
      () => _repository.getDailyDialogs(complexity: complexity),
      isAIGeneration: false,
    );
  }
}
