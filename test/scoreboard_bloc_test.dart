import 'package:bloc_test/bloc_test.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_events.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_state.dart';

void main() {
  late ScoreboardBloc bloc;

  group('incrementing', () {
    setUp(() {
      bloc = ScoreboardBloc(scoreCap: 25);
    });

    blocTest(
      'the score for team 1 updates the correct value and does not affect team 2',
      build: () => bloc,
      act: (bloc) => bloc.add((Team1Increment())),
      expect: () => [
        const ScoreboardState(ScoreboardStatus.ongoing,
            team1Score: 1, team2Score: 0)
      ],
    );

    blocTest(
      'the score for team 2 updates the correct value and does not affect team 1',
      build: () => bloc,
      act: (bloc) => bloc.add((Team2Increment())),
      expect: () => [
        const ScoreboardState(ScoreboardStatus.ongoing,
            team1Score: 0, team2Score: 1)
      ],
    );

    blocTest(
      'to a value that equals the score cap changes the status to ended',
      build: () => ScoreboardBloc(scoreCap: 1),
      act: (bloc) => bloc.add(Team1Increment()),
      expect: () => [
        const ScoreboardState(ScoreboardStatus.ended,
            team1Score: 1, team2Score: 0)
      ],
    );

    group('after the score cap is reached', () {
      setUp(
        () => bloc = ScoreboardBloc(
          scoreCap: 25,
          initialState: const ScoreboardState(ScoreboardStatus.ended,
              team1Score: 25, team2Score: 20),
        ),
      );

      blocTest(
        'for team 1 does not update the value',
        build: () => bloc,
        act: (bloc) => bloc.add(Team1Increment()),
        expect: () => [],
      );

      blocTest(
        'for team 2 does not update the value',
        build: () => bloc,
        act: (bloc) => bloc.add(Team2Increment()),
        expect: () => [],
      );
    });
  });

  group('decrementing', () {
    group('an ongoing board', () {
      setUp(() {
        bloc = ScoreboardBloc(
            scoreCap: 25,
            initialState: const ScoreboardState(ScoreboardStatus.ongoing,
                team1Score: 10, team2Score: 23));
      });

      blocTest(
        'team 1 score updates their score and not team 2',
        build: () => bloc,
        act: (bloc) => bloc.add(Team1Decrement()),
        expect: () => [
          const ScoreboardState(ScoreboardStatus.ongoing,
              team1Score: 9, team2Score: 23)
        ],
      );

      blocTest(
        'team 2 score updates their score and not team 1',
        build: () => bloc,
        act: (bloc) => bloc.add(Team2Decrement()),
        expect: () => [
          const ScoreboardState(ScoreboardStatus.ongoing,
              team1Score: 10, team2Score: 22)
        ],
      );
    });

    group('an ended board', () {
      setUp(() {
        bloc = ScoreboardBloc(
            scoreCap: 25,
            initialState: const ScoreboardState(ScoreboardStatus.ended,
                team1Score: 25, team2Score: 20));
      });

      blocTest(
        'for team 1 does not emit an update',
        build: () => bloc,
        act: (bloc) => bloc.add(Team1Decrement()),
        expect: () => [],
      );

      blocTest(
        'for team 2 does not emit an update',
        build: () => bloc,
        act: (bloc) => bloc.add(Team2Decrement()),
        expect: () => [],
      );
    });
  });
}
