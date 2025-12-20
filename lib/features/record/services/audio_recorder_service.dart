import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  late final RecorderController recorderController;
  String? _path;
  final record = AudioRecorder();

  AudioRecorderService() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  Future<bool> hasPermission() async {
    final status = await Permission.microphone.status;
    // Check and request permission if needed
    if (await record.hasPermission()) {}

    if (status.isGranted) {
      return true;
    }
    final result = await Permission.microphone.request();
    return result.isGranted;
  }

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    _path = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

    final hasPerm = await hasPermission();

    if (await record.hasPermission()) {
      // Start recording to file
      // await record.start(const RecordConfig(), path: _path ?? "");
      // ... or to stream
      final stream = await record.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits),
      );
    }
    if (!hasPerm) return;

    await recorderController.record(path: _path);
  }

  Future<String?> stopRecording() async {
    // Stop recording...
    final path = await record.stop();
    // ... or cancel it (and implicitly remove file/blob).
    // await record.cancel();

    // record.dispose(); // As always, don't forget this one.
    await recorderController.stop();
    return path;
  }

  void dispose() {
    recorderController.dispose();
  }
}
