import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';

enum GameCategory { social, trivia, drawing, party, strategy }

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required String name,
    required String description,
    required int minPlayers,
    required int maxPlayers,
    required int estimatedDuration,
    required GameCategory category,
    required String emoji,
    required List<String> tags,
    String? website,
  }) = _Game;

  const Game._();

  String get playersText {
    if (minPlayers == maxPlayers) {
      return '$minPlayers players';
    }
    return '$minPlayers-$maxPlayers players';
  }

  String get durationText {
    if (estimatedDuration < 60) {
      return '$estimatedDuration min';
    }
    final hours = estimatedDuration ~/ 60;
    final minutes = estimatedDuration % 60;
    if (minutes == 0) {
      return '$hours hr';
    }
    return '$hours hr $minutes min';
  }
}
