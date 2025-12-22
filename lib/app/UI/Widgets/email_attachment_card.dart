import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:secure_email_viewer/app/UI/Widgets/verification_badge_widget.dart';

/// Card widget for displaying email image attachments with verification.
class EmailAttachmentCard extends StatelessWidget {
  const EmailAttachmentCard({
    required this.imageBytes,
    required this.isVerified,
    super.key,
  });

  final List<int> imageBytes;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();
    final hasImage = imageBytes.isNotEmpty;
    final borderColor = hasImage
        ? (isVerified ? Colors.green : Colors.red).withOpacity(0.3)
        : Colors.grey.withOpacity(0.3);

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: theme?.cardBackgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file,
                    size: 18,
                    color: theme?.iconColor ?? Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Attachment',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: theme?.textColor ?? Colors.black,
                    ),
                  ),
                  const Spacer(),
                  if (hasImage)
                    VerificationBadgeWidget(isVerified: isVerified, size: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: hasImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Uint8List.fromList(imageBytes),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(
                          theme,
                          Icons.broken_image,
                          'Failed to load image',
                        ),
                      ),
                    )
                  : _buildPlaceholder(
                      theme,
                      Icons.image_not_supported,
                      'No image attached',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(SecureEmail? theme, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(color: theme?.textColor ?? Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
