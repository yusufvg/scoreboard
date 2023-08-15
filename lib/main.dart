import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoreboard/core/routes.dart';
import 'package:scoreboard/core/services/service_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoreboard',
      routes: routes,
    );
  }
}
