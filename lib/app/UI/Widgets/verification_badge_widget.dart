import 'package:flutter/material.dart';
import 'package:secure_email_viewer/app/UI/Utils/Constants/Constants.dart';

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
      message: isVerified ? AppTexts.verified : AppTexts.verificationFailed,
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
