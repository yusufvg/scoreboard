sealed class ScoreboardEvent {}

final class Team1Increment extends ScoreboardEvent {}

final class Team2Increment extends ScoreboardEvent {}

final class Team1Decrement extends ScoreboardEvent {}

final class Team2Decrement extends ScoreboardEvent {}

final class ResetBoard extends ScoreboardEvent {}
