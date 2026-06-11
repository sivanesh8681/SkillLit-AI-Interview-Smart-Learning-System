import 'package:flutter/material.dart';

class AnimationLayer extends StatefulWidget {
  const AnimationLayer({super.key});

  @override
  State<AnimationLayer> createState() => _AnimationLayerState();
}

class _AnimationLayerState extends State<AnimationLayer> {
  String? currentAnimation;

  void play(String animation) {
    setState(() => currentAnimation = animation);
  }

  @override
  Widget build(BuildContext context) {
    if (currentAnimation == null) {
      return const SizedBox();
    }

    // DAY-2 SIMPLE BUT PREMIUM PLACEHOLDER
    // DAY-3 → Real Lottie / Canvas animations
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Container(
        key: ValueKey(currentAnimation),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "🎬 $currentAnimation",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
