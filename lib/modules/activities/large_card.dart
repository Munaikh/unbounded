import 'package:apparence_kit/core/location/providers/user_location_provider.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LargeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String distance;
  final int price;
  final int minGroupSize;
  final int maxGroupSize;
  const LargeCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.distance,
    required this.price,
    required this.minGroupSize,
    required this.maxGroupSize,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      child: Container(
        width: (MediaQuery.of(context).size.width) * .7,
        margin: const EdgeInsets.only(right: 16),
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(30),
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
                      color: context.colors.onSurface.withValues(alpha: .6),
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
                      Consumer(
                        builder: (context, ref, child) {
                          final parts = distance.split(',');
                          var finalDistance = 'N/A';
                          if (parts.length == 2) {
                            final lat = double.tryParse(parts[0].trim());
                            final lng = double.tryParse(parts[1].trim());
                            if (lat != null && lng != null) {
                              final userLocation = ref.watch(
                                userLocationProvider.notifier,
                              );
                              userLocation.getUserLocation();
                              final distanceMeters = userLocation.getDistanceTo(
                                lat,
                                lng,
                              );
                              final distanceKm = (distanceMeters / 1000)
                                  .toStringAsFixed(1);
                              finalDistance = '$distanceKm km';
                            }
                          }
                          return Text(
                            finalDistance,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colors.primary,
                            ),
                          );
                        }
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
                        '$minGroupSize-$maxGroupSize',
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
  }
}
