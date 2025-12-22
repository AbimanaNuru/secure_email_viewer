import 'package:flutter/material.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading skeleton that matches the email viewer layout.
class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();

    return Shimmer.fromColors(
      baseColor: theme?.shimmerBaseColor ?? Colors.grey[300]!,
      highlightColor: theme?.shimmerHighlightColor ?? Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _box(250, 48),
            const SizedBox(height: 12),
            _box(200, 48),
            const SizedBox(height: 24),
            _box(double.infinity, 150),
            const SizedBox(height: 24),
            _box(double.infinity, 250),
          ],
        ),
      ),
    );
  }

  Widget _box(double width, double height) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
