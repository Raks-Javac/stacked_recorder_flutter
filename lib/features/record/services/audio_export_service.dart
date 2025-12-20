import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AudioExportService {
  Future<String> exportAudio(String sourcePath, {String? customName}) async {
    final file = File(sourcePath);
    if (!await file.exists()) {
      throw Exception('Source file not found');
    }

    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        customName ?? 'exported_${DateTime.now().millisecondsSinceEpoch}.wav';
    final exportPath = path.join(directory.path, fileName);

    // Copy the file
    await file.copy(exportPath);

    return exportPath;
  }

  Future<void> shareAudio(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found');
    }

    await Share.shareXFiles([XFile(filePath)], subject: 'My Audio Recording');
  }

  Future<void> deleteAudio(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
