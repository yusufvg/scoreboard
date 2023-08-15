import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/scoreboard'),
                child: const Text('Scoreboard'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/settings'),
                child: const Text('Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
