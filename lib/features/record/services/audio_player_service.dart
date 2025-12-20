import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioPlayerService {
  final PlayerController playerController = PlayerController();
  SoundHandle? _currentHandle;
  AudioSource? _currentStream;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!SoLoud.instance.isInitialized) {
      await SoLoud.instance.init(sampleRate: 44100, channels: Channels.mono);
    }
    _isInitialized = true;
  }

  Future<void> play(String path) async {
    // Check if file exists
    if (!await File(path).exists()) {
      throw Exception('Audio file not found at: $path');
    }

    await init();

    // Stop any existing playback
    await stop();

    try {
      debugPrint('Playing audio at path: $path');

      // Read the audio file
      final file = File(path);
      final bytes = await file.readAsBytes();

      // Create a buffer stream for SoLoud
      _currentStream = await SoLoud.instance.setBufferStream(
        bufferingType: BufferingType.released,
        bufferingTimeNeeds: 0,
        format: BufferType.s16le,
      );

      // Play the stream
      _currentHandle = await SoLoud.instance.play(_currentStream!);

      // Add audio data to the stream
      SoLoud.instance.addAudioDataStream(_currentStream!, bytes);

      // Mark stream as ended
      SoLoud.instance.setDataIsEnded(_currentStream!);

      // Also use playerController for waveform visualization
      try {
        await playerController.preparePlayer(path: path, noOfSamples: 100);
        await playerController.startPlayer();
      } catch (waveformError) {
        debugPrint('Waveform visualization not available: $waveformError');
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
      rethrow;
    }
  }

  Future<void> pause() async {
    if (_currentHandle != null) {
      SoLoud.instance.pauseSwitch(_currentHandle!);
    }
    try {
      await playerController.pausePlayer();
    } catch (e) {
      debugPrint('PlayerController pause error: $e');
    }
  }

  Future<void> stop() async {
    if (_currentHandle != null) {
      await SoLoud.instance.stop(_currentHandle!);
      _currentHandle = null;
    }
    if (_currentStream != null) {
      await SoLoud.instance.disposeSource(_currentStream!);
      _currentStream = null;
    }
    try {
      await playerController.stopPlayer();
    } catch (e) {
      debugPrint('PlayerController stop error: $e');
    }
  }

  void dispose() {
    if (_currentHandle != null) {
      SoLoud.instance.stop(_currentHandle!);
    }
    if (_currentStream != null) {
      SoLoud.instance.disposeSource(_currentStream!);
    }
    if (_isInitialized) {
      SoLoud.instance.deinit();
    }
    playerController.dispose();
  }
}
