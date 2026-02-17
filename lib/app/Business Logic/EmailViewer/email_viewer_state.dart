import 'package:equatable/equatable.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Models/protos/email.pb.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Repositories/email_repository.dart';

abstract class EmailViewerState extends Equatable {
  const EmailViewerState();
  @override
  List<Object> get props => [];
}

class EmailInitial extends EmailViewerState {}

class EmailLoading extends EmailViewerState {}

class EmailLoaded extends EmailViewerState {

  const EmailLoaded(this.message, this.validationResult);
  final EmailMessage message;
  final ValidationResult validationResult;

  @override
  List<Object> get props => [message, validationResult];
}

class EmailError extends EmailViewerState {
  const EmailError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
