import 'package:animated_gradient/animated_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedGradientBox extends HookWidget {
  final List<Gradient> gradients;
  final Curve curve;

  AnimatedGradientBox(this.gradients, [this.curve = Curves.linear]);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(gradient: useAnimatedGradient(gradients: gradients, curve: curve)));
  }
}
