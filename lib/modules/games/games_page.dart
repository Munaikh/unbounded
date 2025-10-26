import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/modules/games/domain/game.dart';
import 'package:apparence_kit/modules/games/ui/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class GamesPage extends ConsumerWidget {
  const GamesPage({super.key});

  static final List<Game> _hardcodedGames = [
    const Game(
      id: '1',
      name: 'Among Us',
      description:
          'Work together to prep the ship, but watch out for impostors trying to sabotage the mission!',
      minPlayers: 4,
      maxPlayers: 15,
      estimatedDuration: 15,
      category: GameCategory.social,
      emoji: '🚀',
      tags: ['Deduction', 'Multiplayer', 'Mobile'],
      website: 'https://www.innersloth.com/games/among-us/',
    ),
    const Game(
      id: '2',
      name: 'Codenames',
      description:
          'Give one-word clues to help your team identify secret agents hidden among other words.',
      minPlayers: 4,
      maxPlayers: 8,
      estimatedDuration: 20,
      category: GameCategory.party,
      emoji: '🕵️',
      tags: ['Word Game', 'Teams', 'Strategy'],
      website: 'https://codenames.game/',
    ),
    const Game(
      id: '3',
      name: 'Jeopardy',
      description:
          'Answer trivia questions in the form of a question across multiple categories to score points!',
      minPlayers: 1,
      maxPlayers: 10,
      estimatedDuration: 30,
      category: GameCategory.trivia,
      emoji: '💡',
      tags: ['Quiz', 'Knowledge', 'Competition'],
      website: 'https://jeopardylabs.com/',
    ),
    const Game(
      id: '4',
      name: 'Jackbox Party Pack',
      description: 'A collection of hilarious party games played with phones as controllers.',
      minPlayers: 3,
      maxPlayers: 8,
      estimatedDuration: 20,
      category: GameCategory.party,
      emoji: '📦',
      tags: ['Drawing', 'Trivia', 'Creative'],
      website: 'https://www.jackboxgames.com/',
    ),
    const Game(
      id: '5',
      name: 'Skribbl.io',
      description: 'Draw and guess words with friends in this fun multiplayer drawing game!',
      minPlayers: 2,
      maxPlayers: 12,
      estimatedDuration: 15,
      category: GameCategory.drawing,
      emoji: '🎨',
      tags: ['Drawing', 'Guessing', 'Online'],
      website: 'https://skribbl.io/',
    ),
    const Game(
      id: '6',
      name: 'Mafia',
      description:
          'A classic social deduction game where villagers try to identify the mafia members.',
      minPlayers: 7,
      maxPlayers: 20,
      estimatedDuration: 45,
      category: GameCategory.social,
      emoji: '🔪',
      tags: ['Deduction', 'Role-playing', 'Classic'],
      website: 'https://en.wikipedia.org/wiki/Mafia_(party_game)',
    ),
    const Game(
      id: '7',
      name: 'Two Truths and a Lie',
      description:
          'Share three statements about yourself - two true and one false. Can others guess the lie?',
      minPlayers: 3,
      maxPlayers: 10,
      estimatedDuration: 20,
      category: GameCategory.social,
      emoji: '🤔',
      tags: ['Icebreaker', 'Simple', 'Personal'],
      website: 'https://icebreakerideas.com/two-truths-and-a-lie/',
    ),
    const Game(
      id: '8',
      name: 'Kahoot!',
      description: 'Create and play engaging quiz games with friends, family, or colleagues!',
      minPlayers: 1,
      maxPlayers: 50,
      estimatedDuration: 15,
      category: GameCategory.trivia,
      emoji: '🎯',
      tags: ['Quiz', 'Educational', 'Fast-paced'],
      website: 'https://kahoot.com/',
    ),
    const Game(
      id: '9',
      name: 'Gartic Phone',
      description: 'The drawing telephone game! Draw what you see, then describe what you see.',
      minPlayers: 4,
      maxPlayers: 30,
      estimatedDuration: 15,
      category: GameCategory.drawing,
      emoji: '📞',
      tags: ['Drawing', 'Telephone', 'Hilarious'],
      website: 'https://garticphone.com/',
    ),
    const Game(
      id: '13',
      name: 'Trivia Murder Party',
      description:
          'Answer trivia questions correctly or face deadly mini-games in this dark trivia game.',
      minPlayers: 1,
      maxPlayers: 8,
      estimatedDuration: 20,
      category: GameCategory.trivia,
      emoji: '☠️',
      tags: ['Jackbox', 'Dark Humor', 'Competition'],
      website: 'https://www.jackboxgames.com/trivia-murder-party/',
    ),
    const Game(
      id: '15',
      name: 'Quiplash',
      description: 'Write funny responses to prompts and vote on the funniest answers!',
      minPlayers: 3,
      maxPlayers: 8,
      estimatedDuration: 15,
      category: GameCategory.party,
      emoji: '😂',
      tags: ['Jackbox', 'Comedy', 'Creative'],
      website: 'https://www.jackboxgames.com/quiplash/',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: LargeLayoutContainer(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Party Games',
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.onBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fun games to play at your next gathering',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colors.onBackground.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: _hardcodedGames.length,
                itemBuilder: (context, index) {
                  final game = _hardcodedGames[index];
                  return GameCard(
                    game: game,
                    onTap: () async {
                      final url = Uri.parse(game.website!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
