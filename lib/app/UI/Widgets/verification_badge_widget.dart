import 'package:flutter/material.dart';

/// Displays a verification badge for cryptographically verified content.
class VerificationBadgeWidget extends StatelessWidget {
  const VerificationBadgeWidget({
    required this.isVerified,
    this.size = 24.0,
    super.key,
  });

  final bool isVerified;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isVerified ? 'Verified Integrity' : 'Verification Failed',
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: (isVerified ? Colors.green : Colors.red).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isVerified ? Icons.verified : Icons.error,
          color: isVerified ? Colors.green : Colors.red,
          size: size,
        ),
      ),
    );
  }
}
