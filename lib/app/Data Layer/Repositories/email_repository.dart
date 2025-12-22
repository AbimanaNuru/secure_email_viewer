import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Models/protos/email.pb.dart';

class EmailRepository {
  Future<EmailMessage> loadEmailMessage(String assetPath) async {
    // Load the protobuf file from assets
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    // Parse the protobuf message
    return EmailMessage.fromBuffer(bytes);
  }

  ValidationResult verifyEmail(EmailMessage message) {
    // Compute SHA-256 hash of the body using UTF-8 encoding
    final bodyBytes = utf8.encode(message.body);
    final computedBodyHash = sha256.convert(bodyBytes).toString();

    // Compute SHA-256 hash of the image bytes
    final computedImageHash = sha256.convert(message.attachedImage).toString();

    return ValidationResult(
      isBodyValid: computedBodyHash == message.bodyHash,
      isImageValid: computedImageHash == message.imageHash,
    );
  }
}

class ValidationResult {
  final bool isBodyValid;
  final bool isImageValid;

  ValidationResult({required this.isBodyValid, required this.isImageValid});

  bool get isValid => isBodyValid && isImageValid;
}
