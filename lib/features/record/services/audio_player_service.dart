import 'package:audio_waveforms/audio_waveforms.dart';

class AudioPlayerService {
  late final PlayerController playerController;

  AudioPlayerService() {
    playerController = PlayerController();
  }

  Future<void> preparePlayer(String path) async {
    await playerController.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  Future<void> startPlayer(String path) async {
    // If not prepared or different path, prepare first
    if (playerController.playerState == PlayerState.stopped) {
      await preparePlayer(path);
    }
    await playerController.startPlayer();
  }

  Future<void> pausePlayer() async {
    await playerController.pausePlayer();
  }

  Future<void> stopPlayer() async {
    await playerController.stopPlayer();
  }

  void dispose() {
    playerController.dispose();
  }
}
