import 'package:flutter/material.dart';
import 'package:proj4_flutter/shared/gradient_scaffold.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  Widget build(BuildContext context) {
    String name = "Teams";
    return GradientScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
        ],
      ),
    );
  }
}
