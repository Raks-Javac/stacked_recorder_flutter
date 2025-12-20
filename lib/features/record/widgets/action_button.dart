import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final String label;
  final bool isActive;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child:
              AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : color,
                      shape: BoxShape.circle,
                      border: isActive
                          ? Border.all(color: color, width: 4)
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      isActive ? Icons.stop_rounded : icon,
                      color: isActive ? color : Colors.white,
                      size: 40,
                    ),
                  )
                  .animate(target: isActive ? 1 : 0)
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.1, 1.1),
                    duration: 200.ms,
                  )
                  .then(delay: 100.ms) // Pulse effect when active
                  .shimmer(
                    duration: 1.seconds,
                    color: Colors.white.withOpacity(0.5),
                  )
                  .listen(
                    callback: (value) {},
                  ), // Just to keep animation logic active if needed
        ),
        const SizedBox(height: 12),
        Text(
          isActive ? "Stop" : label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
