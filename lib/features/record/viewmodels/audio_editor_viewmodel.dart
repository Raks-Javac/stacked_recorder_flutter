import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../services/audio_effects_service.dart';
import '../services/audio_export_service.dart';
import '../services/audio_player_service.dart';

class AudioEditorViewModel extends BaseViewModel {
  final _playerService = locator<AudioPlayerService>();
  final _effectsService = locator<AudioEffectsService>();
  final _exportService = locator<AudioExportService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  PlayerController get playerController => _playerService.playerController;

  String? _audioFilePath;
  bool _isPlaying = false;
  String _selectedEffect = 'Normal';

  bool get isPlaying => _isPlaying;
  String get selectedEffect => _selectedEffect;
  double get currentPitch => _effectsService.currentPitch;

  void init(String filePath) {
    _audioFilePath = filePath;
  }

  Future<void> togglePlayback() async {
    if (_audioFilePath == null) return;

    if (_isPlaying) {
      await _playerService.pause();
      _isPlaying = false;
    } else {
      try {
        await _playerService.play(
          _audioFilePath!,
          sampleRateRatio: _effectsService.currentPitch,
        );
        _isPlaying = true;

        _playerService.playerController.onCompletion.listen((_) {
          _isPlaying = false;
          notifyListeners();
        });
      } catch (e) {
        _bottomSheetService.showBottomSheet(
          title: 'Playback Error',
          description: e.toString(),
        );
      }
    }
    notifyListeners();
  }

  void applyEffect(String effectName) {
    // Pause playback if playing
    if (_isPlaying) {
      pause();
    }

    _selectedEffect = effectName;

    switch (effectName) {
      case 'Chipmunk':
        _effectsService.applyChipmunkVoice();
        break;
      case 'Deep Voice':
        _effectsService.applyDeepVoice();
        break;
      case 'Normal':
      default:
        _effectsService.resetEffects();
    }

    notifyListeners();
  }

  Future<void> pause() async {
    if (_isPlaying) {
      await _playerService.pause();
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> exportAudio() async {
    if (_audioFilePath == null) return;

    try {
      setBusy(true);
      final exportedPath = await _exportService.exportAudio(_audioFilePath!);

      _bottomSheetService.showBottomSheet(
        title: 'Export Successful',
        description: 'Audio saved to: $exportedPath',
      );
    } catch (e) {
      _bottomSheetService.showBottomSheet(
        title: 'Export Failed',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> shareAudio() async {
    if (_audioFilePath == null) return;

    try {
      await _exportService.shareAudio(_audioFilePath!);
    } catch (e) {
      _bottomSheetService.showBottomSheet(
        title: 'Share Failed',
        description: e.toString(),
      );
    }
  }

  void goBack() {
    _navigationService.back();
  }

  @override
  void dispose() {
    if (_isPlaying) {
      _playerService.stop();
    }

    _playerService.dispose();
    playerController.dispose();

    super.dispose();
  }
}
