import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoreboard/core/services/service_provider.dart';
import 'package:scoreboard/core/services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = getIt<SettingsService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SettingRow(
            'Max Score',
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => settings.scoreCap =
                    int.parse(value.isNotEmpty ? value : '25'),
              ),
            ),
          ),
          SettingRow(
            'Team 1 Color',
            BlockPicker(
              availableColors: settings.availableColors,
              layoutBuilder: (context, colors, child) => SizedBox(
                width: 300,
                height: 75,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: [for (Color color in colors) child(color)],
                ),
              ),
              pickerColor: settings.team1Color,
              onColorChanged: ((value) => settings.team1Color = value),
            ),
          ),
          SettingRow(
            'Team 2 Color',
            BlockPicker(
              availableColors: settings.availableColors,
              layoutBuilder: (context, colors, child) => SizedBox(
                width: 300,
                height: 75,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: [for (Color color in colors) child(color)],
                ),
              ),
              pickerColor: settings.team2Color,
              onColorChanged: ((value) => settings.team2Color = value),
            ),
          ),
          SettingRow(
            'Landscape Scoreboard',
            Switch.adaptive(
                value: settings.isLandscapeMode,
                onChanged: (value) => setState(() {
                      settings.isLandscapeMode = value;
                    })),
          )
        ]),
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  final String settingTitle;
  final Widget control;

  const SettingRow(this.settingTitle, this.control, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(settingTitle),
        control,
      ],
    );
  }
}
