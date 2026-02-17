import 'package:bloc/bloc.dart';
import 'package:secure_email_viewer/app/Business%20Logic/EmailViewer/email_viewer_event.dart';
import 'package:secure_email_viewer/app/Business%20Logic/EmailViewer/email_viewer_state.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Repositories/email_repository.dart';

export 'email_viewer_event.dart';
export 'email_viewer_state.dart';

class EmailViewerBloc extends Bloc<EmailViewerEvent, EmailViewerState> {

  EmailViewerBloc({required this.repository}) : super(EmailInitial()) {
    on<LoadEmailEvent>(_onLoadEmail);
  }
  final EmailRepository repository;

  Future<void> _onLoadEmail(
    LoadEmailEvent event,
    Emitter<EmailViewerState> emit,
  ) async {
    emit(EmailLoading());
    try {
      final message = await repository.loadEmailMessage(event.path);
      final validation = repository.verifyEmail(message);
      emit(EmailLoaded(message, validation));
    } catch (e) {
      emit(EmailError('Failed to load email: $e'));
    }
  }
}
