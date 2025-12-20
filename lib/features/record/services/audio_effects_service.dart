import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:path_provider/path_provider.dart';

class AudioEffectsService {
  // Pitch shift values
  static const double chipmunkPitch = 1.5; // Higher pitch
  static const double deepVoicePitch = 0.7; // Lower pitch
  static const double normalPitch = 1.0;

  double _currentPitch = normalPitch;
  double _currentSpeed = normalSpeed;

  // Speed values
  static const double fastSpeed = 1.5;
  static const double slowSpeed = 0.7;
  static const double normalSpeed = 1.0;

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

  // Apply effects to a SoundHandle in real-time
  void applyEffectsToHandle(SoundHandle handle) {
    if (_currentPitch != normalPitch) {
      SoLoud.instance.setRelativePlaySpeed(handle, _currentPitch);
    }
  }

  /// Process audio file and apply effects by manipulating sample rate
  /// This creates chipmunk (high pitch) or deep voice (low pitch) effects
  Future<String> processAudioWithEffects(
    String inputPath,
    String effectType,
  ) async {
    try {
      final file = File(inputPath);
      if (!await file.exists()) {
        throw Exception('Input file not found');
      }

      // Read the original audio file
      final bytes = await file.readAsBytes();

      // For WAV files, we need to manipulate the header and data
      // WAV header is 44 bytes, then comes the audio data
      if (bytes.length < 44) {
        throw Exception('Invalid WAV file');
      }

      // Extract WAV header (first 44 bytes)
      final header = bytes.sublist(0, 44);
      final audioData = bytes.sublist(44);

      // Get original sample rate from WAV header (bytes 24-27)
      final originalSampleRate = ByteData.sublistView(
        Uint8List.fromList(header.sublist(24, 28)),
      ).getUint32(0, Endian.little);

      int newSampleRate;
      Uint8List processedData;

      switch (effectType) {
        case 'Chipmunk':
          // Increase sample rate for higher pitch (chipmunk voice)
          newSampleRate = (originalSampleRate * chipmunkPitch).round();
          processedData = _resampleAudio(audioData, chipmunkPitch);
          break;

        case 'Deep Voice':
          // Decrease sample rate for lower pitch (deep voice)
          newSampleRate = (originalSampleRate * deepVoicePitch).round();
          processedData = _resampleAudio(audioData, deepVoicePitch);
          break;

        default:
          // No effect
          newSampleRate = originalSampleRate;
          processedData = Uint8List.fromList(audioData);
      }

      // Create new WAV header with modified sample rate
      final newHeader = Uint8List.fromList(header);
      final sampleRateBytes = ByteData(4)
        ..setUint32(0, newSampleRate, Endian.little);
      newHeader.setRange(24, 28, sampleRateBytes.buffer.asUint8List());

      // Update byte rate (sample rate * num channels * bits per sample / 8)
      final numChannels = ByteData.sublistView(
        Uint8List.fromList(header.sublist(22, 24)),
      ).getUint16(0, Endian.little);
      final bitsPerSample = ByteData.sublistView(
        Uint8List.fromList(header.sublist(34, 36)),
      ).getUint16(0, Endian.little);
      final byteRate = newSampleRate * numChannels * bitsPerSample ~/ 8;
      final byteRateBytes = ByteData(4)..setUint32(0, byteRate, Endian.little);
      newHeader.setRange(28, 32, byteRateBytes.buffer.asUint8List());

      // Combine new header with processed audio data
      final processedBytes = Uint8List.fromList([
        ...newHeader,
        ...processedData,
      ]);

      // Save to new file
      final dir = await getApplicationDocumentsDirectory();
      final outputPath =
          '${dir.path}/processed_${DateTime.now().millisecondsSinceEpoch}.wav';
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(processedBytes);

      return outputPath;
    } catch (e) {
      print('Error processing audio: $e');
      rethrow;
    }
  }

  /// Simple resampling by duplicating or skipping samples
  Uint8List _resampleAudio(List<int> audioData, double ratio) {
    if (ratio == 1.0) return Uint8List.fromList(audioData);

    final result = <int>[];

    if (ratio > 1.0) {
      // Chipmunk: Skip samples to speed up (higher pitch)
      for (int i = 0; i < audioData.length; i += 2) {
        if (i % ratio.round() == 0) {
          result.add(audioData[i]);
          if (i + 1 < audioData.length) {
            result.add(audioData[i + 1]);
          }
        }
      }
    } else {
      // Deep voice: Duplicate samples to slow down (lower pitch)
      final duplicateFactor = (1 / ratio).round();
      for (int i = 0; i < audioData.length; i += 2) {
        for (int j = 0; j < duplicateFactor; j++) {
          result.add(audioData[i]);
          if (i + 1 < audioData.length) {
            result.add(audioData[i + 1]);
          }
        }
      }
    }

    return Uint8List.fromList(result);
  }
}
