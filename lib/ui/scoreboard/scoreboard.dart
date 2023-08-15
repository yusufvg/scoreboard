import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoreboard/core/services/service_provider.dart';
import 'package:scoreboard/core/services/settings_service.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_bloc.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_events.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_state.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  final settings = getIt<SettingsService>();

  @override
  void initState() {
    super.initState();
    if (settings.isLandscapeMode) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ScoreboardBloc(scoreCap: settings.scoreCap),
        child: const ScoreboardView(),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}

class ScoreboardView extends StatelessWidget {
  const ScoreboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settings = getIt<SettingsService>();

    return Stack(
      alignment: Alignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            Widget board;

            if (settings.isLandscapeMode) {
              board = Row(
                children: [
                  ScoreboardTile(
                    Size(constraints.maxWidth / 2, constraints.maxHeight),
                  ),
                  ScoreboardTile(
                    Size(constraints.maxWidth / 2, constraints.maxHeight),
                    isTeam1: false,
                  ),
                ],
              );
            } else {
              board = Column(
                children: [
                  ScoreboardTile(
                    Size(constraints.maxWidth, constraints.maxHeight / 2),
                  ),
                  ScoreboardTile(
                    Size(constraints.maxWidth, constraints.maxHeight / 2),
                    isTeam1: false,
                  ),
                ],
              );
            }

            return board;
          },
        ),
        if (settings.isLandscapeMode)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                    onPressed: () =>
                        context.read<ScoreboardBloc>().add(ResetBoard()),
                    icon: const Icon(Icons.refresh),
                    color: Colors.white),
              ),
            ],
          ),
        if (!settings.isLandscapeMode)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                    onPressed: () =>
                        context.read<ScoreboardBloc>().add(ResetBoard()),
                    icon: const Icon(Icons.refresh),
                    color: Colors.white),
              ),
            ],
          ),
      ],
    );
  }
}

class ScoreboardTile extends StatelessWidget {
  const ScoreboardTile(this.size, {this.isTeam1 = true, super.key});

  final Size size;
  final bool isTeam1;

  @override
  Widget build(BuildContext context) {
    bool? isSwipeUp;
    final settings = getIt<SettingsService>();

    return BlocBuilder<ScoreboardBloc, ScoreboardState>(
      builder: (context, state) => GestureDetector(
        onPanUpdate: (details) => isSwipeUp = details.delta.dy < 0,
        onPanEnd: (details) {
          if (isTeam1) {
            if (isSwipeUp ?? false) {
              context.read<ScoreboardBloc>().add(Team1Increment());
            } else if (!(isSwipeUp ?? true)) {
              context.read<ScoreboardBloc>().add(Team1Decrement());
            }
          } else {
            if (isSwipeUp ?? false) {
              context.read<ScoreboardBloc>().add(Team2Increment());
            } else if (!(isSwipeUp ?? true)) {
              context.read<ScoreboardBloc>().add(Team2Decrement());
            }
          }
          isSwipeUp = null;
        },
        child: Container(
          decoration: BoxDecoration(
              color: isTeam1 ? settings.team1Color : settings.team2Color),
          child: SizedBox.fromSize(
            size: size,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '${isTeam1 ? state.team1Score : state.team2Score}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
