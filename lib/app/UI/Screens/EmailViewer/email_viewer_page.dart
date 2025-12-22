import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_email_viewer/app/Business Logic/Theme/theme_cubit.dart';
import 'package:secure_email_viewer/app/Business%20Logic/EmailViewer/email_viewer_bloc.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:secure_email_viewer/app/Data%20Layer/Repositories/email_repository.dart';
import 'package:shimmer/shimmer.dart';

class EmailViewerPage extends StatelessWidget {
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

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SecureEmail>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Secure Email Viewer',
          style: TextStyle(color: theme?.textColor ?? Colors.white),
        ),
        backgroundColor: theme?.appBarColor,
        iconTheme: IconThemeData(color: theme?.iconColor ?? Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<EmailViewerBloc, EmailViewerState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildBody(context, state, theme),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    EmailViewerState state,
    SecureEmail? theme,
  ) {
    if (state is EmailLoading || state is EmailInitial) {
      return _buildShimmerLoading(context, theme);
    }
    if (state is EmailError) {
      return Center(
        key: const ValueKey('Error'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading email',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: TextStyle(color: theme?.textColor ?? Colors.black),
            ),
          ],
        ),
      );
    }
    if (state is EmailLoaded) {
      final msg = state.message;
      final validation = state.validationResult;

      return SingleChildScrollView(
        key: const ValueKey('Content'),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, 'From:', msg.senderEmailAddress, theme),
            const SizedBox(height: 8),
            _buildHeader(context, 'Subject:', msg.subject, theme),
            const Divider(height: 32),
            Text(
              'Message Body:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme?.textColor ?? Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            _buildBodyWithBadge(
              context,
              msg.body,
              validation.isBodyValid,
              theme,
            ),
            const SizedBox(height: 24),
            Text(
              'Attachment:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme?.textColor ?? Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            _buildImageWithBadge(
              context,
              msg.attachedImage,
              validation.isImageValid,
              theme,
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildShimmerLoading(BuildContext context, SecureEmail? theme) {
    return Shimmer.fromColors(
      key: const ValueKey('Loading'),
      baseColor: theme?.shimmerBaseColor ?? Colors.grey[300]!,
      highlightColor: theme?.shimmerHighlightColor ?? Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 200, height: 20, color: Colors.white),
            const SizedBox(height: 8),
            Container(width: 150, height: 20, color: Colors.white),
            const Divider(height: 32),
            Container(width: 100, height: 20, color: Colors.white),
            const SizedBox(height: 8),
            Container(width: double.infinity, height: 100, color: Colors.white),
            const SizedBox(height: 24),
            Container(width: 100, height: 20, color: Colors.white),
            const SizedBox(height: 8),
            Container(width: double.infinity, height: 200, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String label,
    String value,
    SecureEmail? theme,
  ) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: theme?.textColor ?? Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget _buildBodyWithBadge(
    BuildContext context,
    String body,
    bool isValid,
    SecureEmail? theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme?.cardBackgroundColor ?? Colors.white,
        border: Border.all(color: theme?.borderColor ?? Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              body,
              style: TextStyle(color: theme?.textColor ?? Colors.black),
            ),
          ),
          _buildValidationBadge(isValid),
        ],
      ),
    );
  }

  Widget _buildImageWithBadge(
    BuildContext context,
    List<int> imageBytes,
    bool isValid,
    SecureEmail? theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageBytes.isNotEmpty)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                Uint8List.fromList(imageBytes),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text(
                  'Failed to load image',
                  style: TextStyle(color: theme?.textColor),
                ),
              ),
            ),
          )
        else
          Expanded(
            child: Text(
              'No image attached',
              style: TextStyle(color: theme?.textColor),
            ),
          ),
        const SizedBox(width: 8),
        _buildValidationBadge(isValid),
      ],
    );
  }

  Widget _buildValidationBadge(bool isValid) {
    return Tooltip(
      message: isValid ? 'Verified Integrity' : 'Verification Failed',
      child: Icon(
        isValid ? Icons.verified : Icons.error,
        color: isValid ? Colors.green : Colors.red,
      ),
    );
  }
}
