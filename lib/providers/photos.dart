import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';
import 'auth.dart';

/// Where member photos are kept.
///
/// A directory inside the app's own storage, alongside the database, so a photo
/// travels with the records rather than pointing at wherever the user happened to
/// pick the file from.
Future<Directory> photoDirectory() async {
  final dir = Directory(
    p.join((await getApplicationSupportDirectory()).path, 'photos'),
  );
  await dir.create(recursive: true);
  return dir;
}

/// Resolved directory, cached so widgets are not each doing platform IO.
final photoDirectoryProvider = FutureProvider<Directory>(
  (ref) => photoDirectory(),
);

/// The file holding one member's photo, or null if they have none.
///
/// Returns null rather than a broken path when the file is missing: the database
/// can outlive the image if app storage is cleared by hand, and a missing photo
/// should fall back to initials rather than a broken box.
final memberPhotoProvider = Provider.family<File?, Member>((ref, member) {
  if (member.photo.isEmpty) return null;

  final dir = ref.watch(photoDirectoryProvider).valueOrNull;
  if (dir == null) return null;

  final file = File(p.join(dir.path, member.photo));
  return file.existsSync() ? file : null;
});

/// Picks a photo for one member and copies it into app storage.
///
/// Returns the stored filename, or null if the picker was dismissed. Does not
/// write to the member record — the caller does that when the form is saved, so
/// choosing a photo and then cancelling the form leaves nothing behind.
Future<String?> pickMemberPhoto() async {
  const types = XTypeGroup(
    label: 'Images',
    extensions: ['png', 'jpg', 'jpeg', 'webp', 'bmp'],
  );

  final picked = await openFile(acceptedTypeGroups: const [types]);
  if (picked == null) return null;

  final bytes = await picked.readAsBytes();
  if (bytes.isEmpty) {
    throw Exception('That file is empty.');
  }
  // A directory of full-resolution phone photos would be gigabytes, and every
  // visible one is decoded into memory to draw a 36px avatar.
  if (bytes.length > 6 * 1024 * 1024) {
    throw Exception('That image is larger than 6 MB. Please use a smaller one.');
  }

  final dir = await photoDirectory();
  final extension = p.extension(picked.name).toLowerCase();

  // Named from the clock rather than the member: a photo is chosen before a new
  // member has an id, and reusing a name would let a stale cached image show for
  // the wrong person.
  final name = 'mem-${DateTime.now().microsecondsSinceEpoch}$extension';
  await File(p.join(dir.path, name)).writeAsBytes(bytes, flush: true);
  return name;
}

/// Deletes a stored photo file. Safe to call with a blank or missing name.
Future<void> deletePhotoFile(String name) async {
  if (name.isEmpty) return;
  final file = File(p.join((await photoDirectory()).path, name));
  if (file.existsSync()) await file.delete();
}

/// Removes photo files no longer referenced by any member.
///
/// Photos outlive the records that pointed at them: a member is soft-deleted, or
/// their photo is replaced, and the old file stays on disk forever. This is
/// called after those operations rather than on a timer, so the folder cannot
/// grow without bound.
Future<int> pruneOrphanPhotos(WidgetRef ref) async {
  final dir = await photoDirectory();
  final referenced = <String>{
    // Every member, including those outside the current branch scope — pruning
    // must never delete a photo just because the signed-in user cannot see it.
    for (final m in await ref.read(repositoryProvider).allMemberPhotos()) m,
  };

  var removed = 0;
  for (final entity in dir.listSync()) {
    if (entity is! File) continue;
    if (referenced.contains(p.basename(entity.path))) continue;
    await entity.delete();
    removed++;
  }
  return removed;
}
