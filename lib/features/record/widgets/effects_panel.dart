import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EffectsPanel extends StatelessWidget {
  final String selectedEffect;
  final Function(String) onEffectSelected;

  const EffectsPanel({
    super.key,
    required this.selectedEffect,
    required this.onEffectSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Voice Effects',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          _buildEffectChip('Normal', Icons.person),
          const SizedBox(height: 12),
          _buildEffectChip('Chipmunk', Icons.pets),
          const SizedBox(height: 12),
          _buildEffectChip('Deep Voice', Icons.record_voice_over),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEffectChip(String effectName, IconData icon) {
    final isSelected = selectedEffect == effectName;

    return GestureDetector(
      onTap: () => onEffectSelected(effectName),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pinkAccent : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.pinkAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              effectName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade800,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
