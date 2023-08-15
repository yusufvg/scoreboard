import 'package:equatable/equatable.dart';

enum ScoreboardStatus { ongoing, ended }

final class ScoreboardState extends Equatable {
  const ScoreboardState(this.status,
      {this.team1Score = 0, this.team2Score = 0});

  final ScoreboardStatus status;
  final int team1Score;
  final int team2Score;

  ScoreboardState copyWith(
      {ScoreboardStatus? status, int? team1Score, int? team2Score}) {
    return ScoreboardState(status ?? this.status,
        team1Score: team1Score ?? this.team1Score,
        team2Score: team2Score ?? this.team2Score);
  }

  @override
  List<Object?> get props => [status, team1Score, team2Score];
}
