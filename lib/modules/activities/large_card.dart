import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LargeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String distance;
  final String price;
  final String groupSize;
  const LargeCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.distance,
    required this.price,
    required this.groupSize,
  });

  @override
  Widget build(BuildContext context) {
    return FakeGlass(
      shape: const LiquidRoundedSuperellipse(borderRadius: Radius.circular(50)),
      child: SizedBox(
        height: 230,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index) {
            return PressableScale(
              child: Container(
                width: (MediaQuery.of(context).size.width) * .7,
                margin: const EdgeInsets.only(right: 16),
      
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: context.colors.surface,
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: context.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colors.onSurface.withValues(
                                alpha: .6,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: context.colors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                distance,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '£ $price',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.group,
                                size: 16,
                                color: context.colors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                groupSize,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
