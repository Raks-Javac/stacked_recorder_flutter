import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioPlayerService {
  final PlayerController playerController = PlayerController();
  AudioSource? _currentSource;
  SoundHandle? _currentHandle;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!SoLoud.instance.isInitialized) {
      await SoLoud.instance.init();
    }
    _isInitialized = true;
  }

  Future<void> play(String path) async {
    // Check if file exists
    if (!await File(path).exists()) {
      throw Exception('Audio file not found at: $path');
    }

    await init();

    // Stop any existing playback completely
    await stop();

    try {
      debugPrint('Playing audio at path: $path');

      // Load and play with SoLoud
      _currentSource = await SoLoud.instance.loadFile(path);
      _currentHandle = await SoLoud.instance.play(_currentSource!);

      // Try to prepare playerController for waveform visualization
      // This might fail for WAV files, so we catch errors
      try {
        await playerController.preparePlayer(path: path, noOfSamples: 100);
        await playerController.startPlayer();
      } catch (waveformError) {
        debugPrint('Waveform visualization not available: $waveformError');
        // Continue without waveform - audio will still play via SoLoud
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
      SoLoud.instance.stop(_currentHandle!);
      _currentHandle = null;
    }
    if (_currentSource != null) {
      await SoLoud.instance.disposeSource(_currentSource!);
      _currentSource = null;
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
    if (_currentSource != null) {
      SoLoud.instance.disposeSource(_currentSource!);
    }
    if (_isInitialized) {
      SoLoud.instance.deinit();
    }
    playerController.dispose();
  }
}
