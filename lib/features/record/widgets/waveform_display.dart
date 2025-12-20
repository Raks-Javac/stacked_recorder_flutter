import 'dart:ui' as ui;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class RecordingWaveform extends StatelessWidget {
  final RecorderController controller;
  final bool isRecording;

  const RecordingWaveform({
    super.key,
    required this.controller,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: isRecording
            ? AudioWaveforms(
                size: Size(MediaQuery.of(context).size.width - 60, 80),
                recorderController: controller,
                enableGesture: true,
                waveStyle: WaveStyle(
                  waveColor: Colors.pinkAccent,
                  showDurationLabel: true,
                  spacing: 8.0,
                  showBottom: false,
                  extendWaveform: true,
                  showMiddleLine: false,
                  gradient: ui.Gradient.linear(
                    const Offset(70, 50),
                    Offset(MediaQuery.of(context).size.width / 2, 0),
                    [Colors.red, Colors.green],
                  ),
                ),
              )
            : Text(
                "Tap Record to Start",
                style: TextStyle(
                  color: Colors.pink.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

class PlayingWaveform extends StatelessWidget {
  final PlayerController controller;
  final bool isPlaying;

  const PlayingWaveform({
    super.key,
    required this.controller,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: AudioFileWaveforms(
          size: Size(MediaQuery.of(context).size.width - 60, 80),
          playerController: controller,
          enableSeekGesture: true,
          waveformType: WaveformType.fitWidth,
          playerWaveStyle: const PlayerWaveStyle(
            fixedWaveColor: Colors.blueAccent,
            liveWaveColor: Colors.blue,
            spacing: 6,
          ),
        ),
      ),
    );
  }
}
