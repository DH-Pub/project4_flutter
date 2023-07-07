import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/colors_const.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient1 = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        COLOR_CONST.green1,
        COLOR_CONST.green2,
        COLOR_CONST.yellow,
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: gradient1),
        child: body,
      ),
    );
  }
}
