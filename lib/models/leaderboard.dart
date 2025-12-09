class Leaderboard 
{
final String id;
final String playerName;
final int seconds;

Leaderboard({
  required this.id,
  required this.playerName,
  required this.seconds,
});

  // Convert a LeaderboardEntry to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': playerName,
      'seconds': seconds,
    };
  }

  // Create a LeaderboardEntry from JSON
  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      id: json['id'],
      playerName: json['name'],
      seconds: json['seconds'],
    );
  }

Leaderboard copyWith({
  String? id,
  String? playerName,
  int? seconds,
}) 
{
  return Leaderboard(
    id: id ?? this.id,
    playerName: playerName ?? this.playerName,
    seconds: seconds ?? this.seconds,
  );

}

}