import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient1 = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(38, 187, 152, 1),
        Color.fromRGBO(12, 240, 187, 1),
        Color.fromRGBO(255, 186, 73, 1),
      ],
    );
    // LinearGradient gradient2 = LinearGradient(
    //   begin: Alignment.topCenter,
    //   end: Alignment.bottomCenter,
    //   colors: [
    //     Colors.white,
    //     Colors.white.withOpacity(1),
    //     Colors.white.withOpacity(0.8),
    //     const Color.fromRGBO(169, 169, 169, 0.322),
    //   ],
    //   stops: const [0, 0.3, 0.4, 0.7],
    // );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient1),
        child: body,
      ),
    );
  }
}
