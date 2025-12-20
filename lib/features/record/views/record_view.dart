import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/record_viewmodel.dart';
import '../widgets/action_button.dart';
import '../widgets/waveform_display.dart';

class RecordView extends StackedView<RecordViewModel> {
  const RecordView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RecordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade50, Colors.white, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Audio Garden",
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade300,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Record your magic moments",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),

                // Recording Section
                _buildSectionHeader("RECORDING"),
                const SizedBox(height: 20),
                RecordingWaveform(
                  controller: viewModel.recorderController,
                  isRecording: viewModel.isRecording,
                ),
                const SizedBox(height: 40),

                // Actions Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      onTap: viewModel.toggleRecording,
                      icon: Icons.mic_rounded,
                      color: Colors.pinkAccent,
                      label: "Record",
                      isActive: viewModel.isRecording,
                    ),
                    ActionButton(
                      onTap: viewModel.togglePlayback,
                      icon: Icons.play_arrow_rounded,
                      color: Colors.blueAccent,
                      label: "Play",
                      isActive: viewModel.isPlaying,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Playback Section
                _buildSectionHeader("PLAYBACK"),
                const SizedBox(height: 20),
                PlayingWaveform(
                  controller: viewModel.playerController,
                  isPlaying: viewModel.isPlaying,
                ),

                const Spacer(),

                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.pink.shade100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: viewModel.isRecording
                            ? Colors.red
                            : (viewModel.isPlaying
                                  ? Colors.green
                                  : Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        viewModel.isRecording
                            ? "Recording..."
                            : (viewModel.isPlaying ? "Playing..." : "Idle"),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(height: 1, width: 30, color: Colors.grey.shade300),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: Colors.grey.shade300)),
      ],
    );
  }

  @override
  RecordViewModel viewModelBuilder(BuildContext context) => RecordViewModel();
}
