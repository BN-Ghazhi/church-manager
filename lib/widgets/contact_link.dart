import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import 'feedback.dart';

/// The kinds of contact detail the app can hand off to another application.
enum ContactKind {
  phone(Icons.call_outlined, 'Call'),
  email(Icons.mail_outlined, 'Email'),
  website(Icons.language, 'Open'),
  map(Icons.place_outlined, 'Map');

  const ContactKind(this.icon, this.action);

  final IconData icon;
  final String action;

  /// Turns a raw value into something the platform can open.
  ///
  /// Phone numbers keep only digits and a leading `+`: a stored
  /// "+233 24 123 4567" is readable but `tel:` will not accept the spaces.
  /// Websites gain a scheme, because "kgc.org" on its own is treated as a
  /// relative path and silently fails to open.
  Uri? uriFor(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return null;

    return switch (this) {
      ContactKind.phone =>
        Uri(scheme: 'tel', path: value.replaceAll(RegExp(r'[^0-9+]'), '')),
      ContactKind.email => Uri(scheme: 'mailto', path: value),
      ContactKind.website => value.startsWith('http')
          ? Uri.tryParse(value)
          : Uri.tryParse('https://$value'),
      ContactKind.map => Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': value}),
    };
  }
}

/// A contact detail shown as a link that opens the right application.
///
/// Falls back to plain text when the value is empty, and says so when nothing on
/// the machine can handle the link — a dead tap that looks like a bug is worse
/// than an honest "no app can open this".
class ContactLink extends StatelessWidget {
  const ContactLink({
    super.key,
    required this.kind,
    required this.value,
    this.label,
  });

  final ContactKind kind;
  final String value;

  /// Shown instead of the raw value, e.g. a branch's address on a map link.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uri = kind.uriFor(value);
    final text = label ?? value;

    if (uri == null) {
      return Text('—', style: theme.textTheme.bodySmall);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => openContact(context, kind, value),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(kind.icon, size: 14, color: theme.colorScheme.primary),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        theme.colorScheme.primary.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens one contact detail, reporting failure rather than doing nothing.
Future<void> openContact(
  BuildContext context,
  ContactKind kind,
  String value,
) async {
  final uri = kind.uriFor(value);
  if (uri == null) return;

  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      showLocalSuccess(context, 'Nothing on this computer can open $value.');
    }
  } catch (error) {
    if (!context.mounted) return;
    showLocalSuccess(context, 'Could not open $value.');
  }
}
