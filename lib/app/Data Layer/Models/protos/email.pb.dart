//
//  Generated code. Do not modify.
//  source: protos/email.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EmailMessage extends $pb.GeneratedMessage {
  factory EmailMessage({
    $core.String? senderEmailAddress,
    $core.String? subject,
    $core.String? body,
    $core.List<$core.int>? attachedImage,
    $core.String? bodyHash,
    $core.String? imageHash,
  }) {
    final $result = create();
    if (senderEmailAddress != null) {
      $result.senderEmailAddress = senderEmailAddress;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (body != null) {
      $result.body = body;
    }
    if (attachedImage != null) {
      $result.attachedImage = attachedImage;
    }
    if (bodyHash != null) {
      $result.bodyHash = bodyHash;
    }
    if (imageHash != null) {
      $result.imageHash = imageHash;
    }
    return $result;
  }
  EmailMessage._() : super();
  factory EmailMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailMessage', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderEmailAddress')
    ..aOS(2, _omitFieldNames ? '' : 'subject')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'attachedImage', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'bodyHash')
    ..aOS(6, _omitFieldNames ? '' : 'imageHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailMessage clone() => EmailMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailMessage copyWith(void Function(EmailMessage) updates) => super.copyWith((message) => updates(message as EmailMessage)) as EmailMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailMessage create() => EmailMessage._();
  EmailMessage createEmptyInstance() => create();
  static $pb.PbList<EmailMessage> createRepeated() => $pb.PbList<EmailMessage>();
  @$core.pragma('dart2js:noInline')
  static EmailMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailMessage>(create);
  static EmailMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderEmailAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderEmailAddress($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderEmailAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderEmailAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get subject => $_getSZ(1);
  @$pb.TagNumber(2)
  set subject($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get attachedImage => $_getN(3);
  @$pb.TagNumber(4)
  set attachedImage($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttachedImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachedImage() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get bodyHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set bodyHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBodyHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearBodyHash() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageHash => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageHash($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasImageHash() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageHash() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
