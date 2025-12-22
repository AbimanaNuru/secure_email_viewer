import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/ThemeComponent.dart';
import 'package:secure_email_viewer/app/Business%20Logic/Theme/theme_cubit.dart';
import 'package:secure_email_viewer/app/UI/Utils/Constants/Constants.dart';

/// Builds a reusable app bar for the Secure Email Viewer app.
///
/// Includes automatic theme toggle button and customizable actions.
AppBar buildAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  bool showBackButton = false,
}) {
  final theme = Theme.of(context);
  final customTheme = theme.extension<SecureEmail>();

  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: customTheme?.appBarColorTitle,
        fontWeight: FontWeight.w600,
      ),
    ),
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop(),
          )
        : null,
    actions: [
      ...?actions,
      // Theme toggle button
      IconButton(
        icon: Icon(
          theme.brightness == Brightness.dark
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
        tooltip: theme.brightness == Brightness.dark
            ? AppTexts.lightMode
            : AppTexts.darkMode,
        onPressed: () {
          context.read<ThemeCubit>().toggleTheme();
        },
      ),
    ],
    backgroundColor: customTheme?.appBarColor,
    elevation: 0,
    scrolledUnderElevation: 1,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: customTheme?.appBarColorTitle,
    ),
  );
}
