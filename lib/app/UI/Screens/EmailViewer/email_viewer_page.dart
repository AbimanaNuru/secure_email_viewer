import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_email_viewer/app/Business%20Logic/EmailViewer/email_viewer_bloc.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Repositories/email_repository.dart';
import 'package:secure_email_viewer/app/UI/Utils/Constants/AppTexts.dart';
import 'package:secure_email_viewer/app/UI/Widgets/app_bar.dart';
import 'package:secure_email_viewer/app/UI/Widgets/email_attachment_card.dart';
import 'package:secure_email_viewer/app/UI/Widgets/email_body_card.dart';
import 'package:secure_email_viewer/app/UI/Widgets/email_header_widget.dart';
import 'package:secure_email_viewer/app/UI/Widgets/error_state_widget.dart';
import 'package:secure_email_viewer/app/UI/Widgets/shimmer_loading_widget.dart';

/// The main email viewer page that displays a secure email message
/// loaded from Protocol Buffer format with hash verification.
class EmailViewerPage extends StatelessWidget {
  /// Creates an email viewer page.
  const EmailViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailViewerBloc(
        repository: EmailRepository(),
      )..add(const LoadEmailEvent('assets/sample_email.pb')),
      child: const EmailView(),
    );
  }
}

/// The email view widget that builds the UI based on BLoC state.
class EmailView extends StatelessWidget {
  /// Creates an email view.
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();

    return Scaffold(
      backgroundColor: theme?.backgroundColor ?? Colors.grey.shade50,

      appBar: buildAppBar(
        context: context,
        title: AppTexts.appTitle,
      ),
      body: BlocBuilder<EmailViewerBloc, EmailViewerState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, EmailViewerState state) {
    // Loading state
    if (state is EmailLoading || state is EmailInitial) {
      return const ShimmerLoadingWidget(
        key: ValueKey('Loading'),
      );
    }

    // Error state
    if (state is EmailError) {
      return ErrorStateWidget(
        key: const ValueKey('Error'),
        message: state.message,
        onRetry: () {
          context.read<EmailViewerBloc>().add(
            const LoadEmailEvent('assets/sample_email.pb'),
          );
        },
      );
    }

    // Loaded state
    if (state is EmailLoaded) {
      final msg = state.message;
      final validation = state.validationResult;

      return SingleChildScrollView(
        key: const ValueKey('Content'),
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email headers
              EmailHeaderWidget(
                label: AppTexts.senderName,
                value: msg.senderName,
                icon: Icons.person,
              ),
              const SizedBox(height: 12),
              EmailHeaderWidget(
                label: AppTexts.senderEmail,
                value: msg.senderEmailAddress,
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 12),
              EmailHeaderWidget(
                label: AppTexts.subject,
                value: msg.subject,
                icon: Icons.subject,
              ),
              const SizedBox(height: 24),

              // Email body
              EmailBodyCard(
                body: msg.body,
                isVerified: validation.isBodyValid,
              ),
              const SizedBox(height: 16),

              // Email attachment
              EmailAttachmentCard(
                imageBytes: msg.attachedImage,
                isVerified: validation.isImageValid,
              ),

              // Bottom spacing for better scrolling
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
