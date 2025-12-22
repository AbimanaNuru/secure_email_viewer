import 'package:flutter/material.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:secure_email_viewer/app/UI/Utils/Constants/Constants.dart';
import 'package:secure_email_viewer/app/UI/Widgets/verification_badge_widget.dart';

/// Card widget for displaying email body with verification status.
class EmailBodyCard extends StatelessWidget {
  const EmailBodyCard({
    required this.body,
    required this.isVerified,
    super.key,
  });

  final String body;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();
    final borderColor = (isVerified ? Colors.green : Colors.red).withOpacity(
      0.3,
    );

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme?.cardBackgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.message,
                  size: 18,
                  color: theme?.iconColor ?? Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  AppTexts.messageBody,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: theme?.textColor ?? Colors.black,
                  ),
                ),
                const Spacer(),
                VerificationBadgeWidget(isVerified: isVerified, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: TextStyle(
                color: theme?.textColor ?? Colors.black87,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
