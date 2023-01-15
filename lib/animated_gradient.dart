import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Gradient useAnimatedGradient({
  Duration duration = const Duration(seconds: 5),
  required List<Gradient> gradients,
  Curve curve = Curves.linear,
}) {
  final controller = useAnimationController(duration: duration);
  final index = useValueNotifier(0);

  useEffect(() {
    controller.repeat();
    listener() {
      final newIndex = (controller.value * gradients.length).floor() % gradients.length;
      if (newIndex != index.value) index.value = newIndex;
    }

    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [gradients, duration, curve]);

  return useAnimation(GradientTween(
    begin: gradients[index.value],
    end: gradients[(index.value + 1) % gradients.length],
  ).animate(CurvedAnimation(
      curve: Interval(
        index.value / gradients.length,
        (index.value + 1) / gradients.length,
        curve: curve,
      ),
      parent: controller)));
}

class GradientTween extends Tween<Gradient> {
  GradientTween({
    required Gradient begin,
    required Gradient end,
  }) : super(begin: begin, end: end);

  @override
  Gradient lerp(double t) => Gradient.lerp(begin, end, t)!;
}
