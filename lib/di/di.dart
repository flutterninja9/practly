import 'package:get_it/get_it.dart';
import 'package:practly/di/setup_core.dart';

final locator = GetIt.I;

Future<void> initializeDeps() async {
  await setupCore();
}
