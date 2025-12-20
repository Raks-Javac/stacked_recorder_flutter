import 'package:flutter_soloud/flutter_soloud.dart';

class AudioEffectsService {
  // Pitch shift values
  static const double chipmunkPitch = 1.5; // Higher pitch
  static const double deepVoicePitch = 0.7; // Lower pitch
  static const double normalPitch = 1.0;

  // Speed values
  static const double fastSpeed = 1.5;
  static const double slowSpeed = 0.7;
  static const double normalSpeed = 1.0;

  double _currentPitch = normalPitch;
  double _currentSpeed = normalSpeed;

  double get currentPitch => _currentPitch;
  double get currentSpeed => _currentSpeed;

  void setPitch(double pitch) {
    _currentPitch = pitch;
  }

  void setSpeed(double speed) {
    _currentSpeed = speed;
  }

  void applyChipmunkVoice() {
    _currentPitch = chipmunkPitch;
  }

  void applyDeepVoice() {
    _currentPitch = deepVoicePitch;
  }

  void resetEffects() {
    _currentPitch = normalPitch;
    _currentSpeed = normalSpeed;
  }

  // Apply effects to a SoundHandle
  void applyEffectsToHandle(SoundHandle handle) {
    if (_currentPitch != normalPitch) {
      SoLoud.instance.setRelativePlaySpeed(handle, _currentPitch);
    }
    // Note: SoLoud doesn't have separate speed control,
    // so we use play speed for both pitch and speed effects
  }
}
