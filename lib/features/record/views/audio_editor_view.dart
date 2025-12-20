import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/audio_editor_viewmodel.dart';
import '../widgets/effects_panel.dart';
import '../widgets/waveform_display.dart';

class AudioEditorView extends StackedView<AudioEditorViewModel> {
  final String audioFilePath;

  const AudioEditorView({super.key, required this.audioFilePath});

  @override
  void onViewModelReady(AudioEditorViewModel viewModel) {
    viewModel.init(audioFilePath);
  }

  @override
  Widget builder(
    BuildContext context,
    AudioEditorViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade50, Colors.white, Colors.pink.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: viewModel.goBack,
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Edit Audio',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: viewModel.shareAudio,
                      icon: const Icon(Icons.share),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Waveform Display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: PlayingWaveform(
                  controller: viewModel.playerController,
                  isPlaying: viewModel.isPlaying,
                ),
              ),

              const SizedBox(height: 40),

              // Play/Pause Button
              GestureDetector(
                onTap: viewModel.togglePlayback,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: viewModel.isPlaying ? Colors.red : Colors.blueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            (viewModel.isPlaying
                                    ? Colors.red
                                    : Colors.blueAccent)
                                .withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    viewModel.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Current Effect Display
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
                    Icon(
                      Icons.auto_fix_high,
                      color: Colors.pinkAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Effect: ${viewModel.selectedEffect}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Effects Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => EffectsPanel(
                        selectedEffect: viewModel.selectedEffect,
                        onEffectSelected: (effect) {
                          viewModel.applyEffect(effect);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune),
                  label: const Text('Apply Effects'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Export Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  onPressed: viewModel.isBusy ? null : viewModel.exportAudio,
                  icon: viewModel.isBusy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.download),
                  label: Text(
                    viewModel.isBusy ? 'Exporting...' : 'Export Audio',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AudioEditorViewModel viewModelBuilder(BuildContext context) =>
      AudioEditorViewModel();
}
