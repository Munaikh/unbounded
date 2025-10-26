import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/games/domain/game.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback? onTap;

  const GameCard({super.key, required this.game, this.onTap});

  Color _getCategoryColor(GameCategory category) {
    return switch (category) {
      GameCategory.social => Colors.blue,
      GameCategory.trivia => Colors.red,
      GameCategory.drawing => Colors.green,
      GameCategory.party => Colors.orange,
      GameCategory.strategy => Colors.purple,
    };
  }

  String _getCategoryName(GameCategory category) {
    return switch (category) {
      GameCategory.social => 'Social',
      GameCategory.trivia => 'Trivia',
      GameCategory.drawing => 'Drawing',
      GameCategory.party => 'Party',
      GameCategory.strategy => 'Strategy',
    };
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(game.category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.colors.surface,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Emoji
                        // Container(
                        //   width: 60,
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //     color: categoryColor.withValues(alpha: 0.15),
                        //     borderRadius: BorderRadius.circular(16),
                        //   ),
                        //   child: Center(
                        //     child: Text(game.emoji, style: const TextStyle(fontSize: 32)),
                        //   ),
                        // ),
                        // const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                game.name,
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: categoryColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _getCategoryName(game.category),
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: categoryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (game.website != null) ...[
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(game.website!);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  size: 16,
                                  // color: categoryColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Visit Website',
                                  style: context.textTheme.labelMedium?.copyWith(
                                    // color: categoryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      game.description,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurface.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(context, Icons.people_outline, game.playersText),
                        _buildInfoChip(context, Icons.timer_outlined, game.durationText),
                      ],
                    ),
                    if (game.tags.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: game.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: context.colors.onSurface.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colors.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.colors.onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.colors.onSurface.withValues(alpha: 0.6)),
          const SizedBox(width: 4),
          Text(
            text,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
