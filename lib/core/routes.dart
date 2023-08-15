import 'package:scoreboard/ui/home/home.dart';
import 'package:scoreboard/ui/scoreboard/scoreboard.dart';
import 'package:scoreboard/ui/settings/settings.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  '/scoreboard': (context) => const ScoreboardScreen(),
  '/settings': (context) => const SettingsScreen(),
};
