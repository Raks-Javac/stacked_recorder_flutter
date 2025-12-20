import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderService {
  late final RecorderController recorderController;
  String? _path;

  AudioRecorderService() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  Future<bool> hasPermission() async {
    final status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    }
    final result = await Permission.microphone.request();
    return result.isGranted;
  }

  Future<void> startRecording() async {
    final hasPerm = await hasPermission();
    if (!hasPerm) return;

    final dir = await getApplicationDocumentsDirectory();
    _path = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await recorderController.record(path: _path);
  }

  Future<String?> stopRecording() async {
    final path = await recorderController.stop();
    return path;
  }

  void dispose() {
    recorderController.dispose();
  }
}
