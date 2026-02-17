import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Models/protos/email.pb.dart';

/// Computes SHA-256 hash of the given data
String sha256Hash(List<int> data) {
  return sha256.convert(data).toString();
}

Future<void> main() async {
  print('🔐 Generating sample email protobuf file...\n');

  // Load image bytes
  final imageFile = File('assets/QTLogo.png');
  if (!await imageFile.exists()) {
    print('❌ Error: assets/sample_image.png not found!');
    print('   Please ensure the image file exists.');
    exit(1);
  }

  final imageBytes = await imageFile.readAsBytes();
  print('✅ Loaded image: ${imageBytes.length} bytes');

  // Email content
  const senderName = 'Nuru Halifa huhuhuhuhh';
  const senderEmail = 'nuruabimana@gmail.com';
  const subject = 'Secure Message';
  const body = 'Implementation of secure email viewer';

  // Compute hashes using UTF-8 encoding for body
  final bodyHash = sha256Hash(utf8.encode(body));
  final imageHash = sha256Hash(imageBytes);

  print('✅ Computed body hash: $bodyHash');
  print('✅ Computed image hash: $imageHash');

  // Create EmailMessage
  final email = EmailMessage()
    ..senderName = senderName
    ..senderEmailAddress = senderEmail
    ..subject = subject
    ..body = body
    ..attachedImage = imageBytes
    ..bodyHash = bodyHash
    ..imageHash = imageHash;

  // Serialize to binary
  final outputFile = File('assets/sample_email.pb');
  await outputFile.writeAsBytes(email.writeToBuffer());

  print('\n🎉 Success! Generated: ${outputFile.path}');
  print('   File size: ${await outputFile.length()} bytes');
  print('\n📧 Email Details:');
  print('   From: $senderEmail');
  print('   Subject: $subject');
  print('   Body: $body');
  print('   Image: ${imageBytes.length} bytes');
}
