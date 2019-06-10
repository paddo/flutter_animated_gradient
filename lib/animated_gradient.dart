import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Gradient useAnimatedGradient({
  Duration duration = const Duration(seconds: 3),
  List<Gradient> gradients,
  bool repeat = true,
  Curve curve = Curves.linear,
}) {
  return Hook.use(_AnimatedGradientHook(
    duration: duration,
    gradients: gradients,
    repeat: repeat,
    curve: curve,
  ));
}

class GradientTween extends Tween<Gradient> {
  GradientTween({
    Gradient begin,
    Gradient end,
  }) : super(begin: begin, end: end);

  @override
  Gradient lerp(double t) => Gradient.lerp(begin, end, t);
}

class _AnimatedGradientHook extends Hook<Gradient> {
  final List<Gradient> gradients;
  final Duration duration;
  final bool repeat;
  final Curve curve;

  _AnimatedGradientHook({this.duration, this.gradients, this.repeat, this.curve});

  @override
  HookState<Gradient, Hook<Gradient>> createState() => _AnimatedGradientHookState();
}

class _AnimatedGradientHookState extends HookState<Gradient, _AnimatedGradientHook> {
  @override
  Gradient build(BuildContext context) {
    final controller = useAnimationController(duration: hook.duration);
    final index = useState(0);

    useEffect(() {
      controller.forward();
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && (hook.repeat || index.value + 2 < hook.gradients.length)) {
          controller.reset();
          controller.forward();
          index.value = (index.value + 1) % hook.gradients.length;
        }
      });
    }, [hook.gradients, hook.duration, hook.repeat, hook.curve]);

    return useAnimation(GradientTween(
            begin: hook.gradients[index.value], end: hook.gradients[(index.value + 1) % hook.gradients.length])
        .animate(CurvedAnimation(curve: hook.curve, parent: controller)));
  }
}
