import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final _recorder = AudioRecorder();
  final recorderController = RecorderController();
  String? _path;

  Future<bool> hasPermission() async {
    return await _recorder.hasPermission();
  }

  Future<void> startRecording() async {
    if (!await hasPermission()) return;

    final dir = await getApplicationDocumentsDirectory();
    _path = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.wav";

    // Start recording with 'record' package in WAV format for SoLoud compatibility
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        noiseSuppress: true,
        sampleRate: 120000,
        streamBufferSize: 1024,
        echoCancel: true,
      ),
      path: _path!,
    );

    // Also start recorderController for visualization only (no path needed for visualization)
    await recorderController.record();
  }

  Future<String?> stopRecording() async {
    final path = await _recorder.stop();
    await recorderController.stop();
    return path;
  }

  void dispose() {
    _recorder.dispose();
    recorderController.dispose();
  }
}
