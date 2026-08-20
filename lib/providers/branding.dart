import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'auth.dart';
import 'repository.dart';

/// The two images a church can replace: the sidebar logo and the sign-in
/// background.
enum BrandImage {
  logo('branding.logo', 'Sidebar logo'),
  signInBackground('branding.signInBackground', 'Sign-in background');

  const BrandImage(this.settingKey, this.label);

  /// Where the chosen file's path is recorded in the settings table.
  final String settingKey;
  final String label;
}

/// The file the church picked for one of the brand images, or null for the
/// built-in default.
///
/// The chosen file is *copied* into the app's own storage rather than
/// referenced where it sits. A path into Downloads or a USB stick breaks the
/// moment the file is moved, and the app would silently lose its logo.
final brandImageProvider = Provider.family<File?, BrandImage>((ref, which) {
  final path = ref.watch(settingsProvider)[which.settingKey];
  if (path == null || path.isEmpty) return null;

  final file = File(path);
  // A missing file falls back to the default rather than showing a broken box:
  // the database can outlive the image if someone clears app storage by hand.
  return file.existsSync() ? file : null;
});

/// Asks for an image, copies it into app storage and records it.
///
/// Returns the saved file, or null if the picker was dismissed. Throws with a
/// readable message if the file cannot be read or copied, so the calling form
/// can show it.
Future<File?> pickBrandImage(WidgetRef ref, BrandImage which) async {
  const types = XTypeGroup(
    label: 'Images',
    extensions: ['png', 'jpg', 'jpeg', 'webp', 'gif', 'bmp'],
  );

  final picked = await openFile(acceptedTypeGroups: const [types]);
  if (picked == null) return null;

  final bytes = await picked.readAsBytes();
  if (bytes.isEmpty) {
    throw Exception('That file is empty.');
  }
  // Images are read into memory to be drawn, and a logo has no business being
  // ten megabytes. The cap is generous for a photo and still safe.
  if (bytes.length > 8 * 1024 * 1024) {
    throw Exception('That image is larger than 8 MB. Please use a smaller one.');
  }

  final dir = Directory(
    p.join((await getApplicationSupportDirectory()).path, 'branding'),
  );
  await dir.create(recursive: true);

  // Named after the slot, not the source file, so replacing an image leaves no
  // orphaned copies behind. The extension is kept so the decoder can tell the
  // format from the path.
  final extension = p.extension(picked.name).toLowerCase();
  final target = File(p.join(dir.path, '${which.name}$extension'));

  // A previous image in a different format would otherwise linger.
  for (final stale in dir.listSync()) {
    if (stale is File &&
        p.basenameWithoutExtension(stale.path) == which.name &&
        stale.path != target.path) {
      await stale.delete();
    }
  }

  await target.writeAsBytes(bytes, flush: true);
  await ref.read(repositoryProvider).saveSetting(which.settingKey, target.path);
  return target;
}

/// Goes back to the built-in image.
Future<void> clearBrandImage(WidgetRef ref, BrandImage which) async {
  final current = ref.read(brandImageProvider(which));
  await ref.read(repositoryProvider).saveSetting(which.settingKey, '');
  if (current != null && current.existsSync()) {
    await current.delete();
  }
}
