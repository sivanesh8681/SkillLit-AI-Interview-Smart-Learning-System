import 'package:flutter/material.dart';
import 'electron_sharing.dart';
import 'heart_pumping.dart';
import 'current_flow.dart';

class AnimationRouter extends StatelessWidget {
  final String animation;

  const AnimationRouter({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    switch (animation) {
      case "electron_sharing_basic":
        return const ElectronSharingAnimation();

      case "heart_blood_flow":
        return const HeartPumpingAnimation();

      case "current_flow_arrow":
        return const CurrentFlowAnimation();

      default:
        return _UnknownAnimation(animation: animation);
    }
  }
}

class _UnknownAnimation extends StatelessWidget {
  final String animation;
  const _UnknownAnimation({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        animation,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
