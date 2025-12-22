import 'package:flutter/material.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';

/// Displays email header fields (From, Subject, etc.)
class EmailHeaderWidget extends StatelessWidget {
  const EmailHeaderWidget({
    required this.label,
    required this.value,
    this.icon,
    super.key,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color:
            theme?.cardBackgroundColor.withOpacity(0.5) ?? Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: theme?.iconColor ?? Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: theme?.textColor ?? Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: '$label ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
