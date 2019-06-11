import 'package:animated_gradient/animated_gradient_box.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Gradient> _linearGradients = [
    LinearGradient(
        colors: [Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.yellow],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight),
    LinearGradient(
        colors: [Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.yellow],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    LinearGradient(
        colors: [Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.yellow],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft),
    LinearGradient(
        colors: [Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.yellow],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
  ];

  final List<Gradient> _sweepGradients = [
    SweepGradient(colors: [Colors.red, Colors.yellow, Colors.green, Colors.red]),
    SweepGradient(colors: [Colors.lightBlue, Colors.purple, Colors.pink, Colors.lightBlue]),
  ];

  final List<Gradient> _radialGradients = [
    RadialGradient(colors: [Colors.red, Colors.blue], radius: 1.0, center: Alignment.topCenter),
    RadialGradient(colors: [Colors.lightBlue, Colors.purple, Colors.pink], radius: 2.0, center: Alignment.bottomCenter),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: AnimatedGradientBox(_linearGradients)),
            Expanded(child: AnimatedGradientBox(_sweepGradients)),
            Expanded(child: AnimatedGradientBox(_radialGradients, Curves.easeInOut)),
            Expanded(
                child: AnimatedGradientBox(
                    []..addAll(_linearGradients)..addAll(_radialGradients)..addAll(_sweepGradients))),
          ],
        ),
      ),
    );
  }
}
