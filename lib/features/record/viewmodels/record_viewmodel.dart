import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_recorder/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../services/audio_player_service.dart';
import '../services/audio_recorder_service.dart';

class RecordViewModel extends BaseViewModel {
  final _recorderService = locator<AudioRecorderService>();
  final _playerService = locator<AudioPlayerService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  RecorderController get recorderController =>
      _recorderService.recorderController;
  PlayerController get playerController => _playerService.playerController;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  String? _recordedFilePath;
  String? get recordedFilePath => _recordedFilePath;

  Future<void> initialized() async {
    // Check permissions on init
    await _recorderService.hasPermission();
  }

  Future<void> toggleRecording() async {
    if (_isRecording) {
      _recordedFilePath = await _recorderService.stopRecording();
      _isRecording = false;
      notifyListeners();
    } else {
      await _recorderService.startRecording();
      _isRecording = true;
      notifyListeners();
    }
  }

  void navigateToEditor() {
    if (_recordedFilePath != null) {
      _navigationService.navigateToAudioEditorView(
        audioFilePath: _recordedFilePath!,
      );
    }
  }

  Future<void> togglePlayback() async {
    if (_recordedFilePath == null) {
      _bottomSheetService.showBottomSheet(
        title: 'No Recording',
        description: 'Please record something first.',
      );
      return;
    }

    if (_isPlaying) {
      await _playerService.pause();
      _isPlaying = false;
      notifyListeners();
    } else {
      try {
        await _playerService.play(_recordedFilePath!);
        _isPlaying = true;
        notifyListeners();

        // Listen for when playback finishes
        _playerService.playerController.onCompletion.listen((_) {
          _isPlaying = false;
          notifyListeners();
        });
      } catch (e) {
        _bottomSheetService.showBottomSheet(
          title: 'Playback Error',
          description: 'Could not play the recording: ${e.toString()}',
        );
      }
    }
  }

  @override
  void dispose() {
    _recorderService.dispose();
    _playerService.dispose();
    super.dispose();
  }
}
