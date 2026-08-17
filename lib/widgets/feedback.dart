import 'package:flutter/material.dart';

/// Honest feedback for actions that have no backend yet.
///
/// Every stub action in the app routes through here rather than pretending to
/// succeed, so a UI preview is never mistaken for working behaviour.
void showStubMessage(BuildContext context, String action) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('$action is not connected yet — this is a UI preview.'),
        behavior: SnackBarBehavior.floating,
        width: 460,
      ),
    );
}

/// Confirmation for actions that "succeed" locally in the preview.
void showLocalSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: 460,
      ),
    );
}
