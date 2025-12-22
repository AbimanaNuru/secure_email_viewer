//
//  Generated code. Do not modify.
//  source: protos/email.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emailMessageDescriptor instead')
const EmailMessage$json = {
  '1': 'EmailMessage',
  '2': [
    {'1': 'sender_email_address', '3': 1, '4': 1, '5': 9, '10': 'senderEmailAddress'},
    {'1': 'subject', '3': 2, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
    {'1': 'attached_image', '3': 4, '4': 1, '5': 12, '10': 'attachedImage'},
    {'1': 'body_hash', '3': 5, '4': 1, '5': 9, '10': 'bodyHash'},
    {'1': 'image_hash', '3': 6, '4': 1, '5': 9, '10': 'imageHash'},
  ],
};

/// Descriptor for `EmailMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailMessageDescriptor = $convert.base64Decode(
    'CgxFbWFpbE1lc3NhZ2USMAoUc2VuZGVyX2VtYWlsX2FkZHJlc3MYASABKAlSEnNlbmRlckVtYW'
    'lsQWRkcmVzcxIYCgdzdWJqZWN0GAIgASgJUgdzdWJqZWN0EhIKBGJvZHkYAyABKAlSBGJvZHkS'
    'JQoOYXR0YWNoZWRfaW1hZ2UYBCABKAxSDWF0dGFjaGVkSW1hZ2USGwoJYm9keV9oYXNoGAUgAS'
    'gJUghib2R5SGFzaBIdCgppbWFnZV9oYXNoGAYgASgJUglpbWFnZUhhc2g=');

