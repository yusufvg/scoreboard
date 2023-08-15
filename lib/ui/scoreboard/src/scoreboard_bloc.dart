import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_events.dart';
import 'package:scoreboard/ui/scoreboard/src/scoreboard_state.dart';

final class ScoreboardBloc extends Bloc<ScoreboardEvent, ScoreboardState> {
  ScoreboardBloc(
      {required int scoreCap,
      ScoreboardState initialState =
          const ScoreboardState(ScoreboardStatus.ongoing)})
      : _scoreCap = scoreCap,
        super(initialState) {
    on<Team1Increment>(_onTeam1Increment);
    on<Team2Increment>(_onTeam2Increment);
    on<Team1Decrement>(_onTeam1Decrement);
    on<Team2Decrement>(_onTeam2Decrement);
    on<ResetBoard>(_onResetBoard);
  }

  final int _scoreCap;

  Future<void> _onTeam1Increment(
      ScoreboardEvent e, Emitter<ScoreboardState> emit) async {
    if (state.status == ScoreboardStatus.ended) return;

    int newScore = state.team1Score + 1;
    emit(state.copyWith(
        status: newScore == _scoreCap
            ? ScoreboardStatus.ended
            : ScoreboardStatus.ongoing,
        team1Score: newScore));
  }

  Future<void> _onTeam2Increment(
      ScoreboardEvent e, Emitter<ScoreboardState> emit) async {
    if (state.status == ScoreboardStatus.ended) return;

    int newScore = state.team2Score + 1;
    emit(state.copyWith(
        status: newScore == _scoreCap
            ? ScoreboardStatus.ended
            : ScoreboardStatus.ongoing,
        team2Score: newScore));
  }

  Future<void> _onTeam1Decrement(
      ScoreboardEvent e, Emitter<ScoreboardState> emit) async {
    if (state.status == ScoreboardStatus.ended) return;

    emit(state.copyWith(team1Score: max(0, state.team1Score - 1)));
  }

  Future<void> _onTeam2Decrement(
      ScoreboardEvent e, Emitter<ScoreboardState> emit) async {
    if (state.status == ScoreboardStatus.ended) return;

    emit(state.copyWith(team2Score: max(0, state.team2Score - 1)));
  }

  Future<void> _onResetBoard(
      ScoreboardEvent e, Emitter<ScoreboardState> emit) async {
    emit(const ScoreboardState(ScoreboardStatus.ongoing));
  }
}
