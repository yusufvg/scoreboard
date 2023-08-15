import 'package:get_it/get_it.dart';
import 'package:scoreboard/core/services/settings_service.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerSingleton<SettingsService>(SettingsService());
}
