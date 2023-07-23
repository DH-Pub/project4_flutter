import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/project_controllers.dart';
import 'package:proj4_flutter/models/project_1.dart';

class RemoveProjectAlert extends StatelessWidget {
  final Function getAllProject;
  final ProjectDetail prj;
  const RemoveProjectAlert(
      {super.key, required this.getAllProject, required this.prj});

  @override
  Widget build(BuildContext context) {
    ProjectController projectController = ProjectController();
    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            const Text(
              "Do you want to remove this project",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              prj.name,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(8),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            projectController.removeProject(prj.id).then((value) {
              if (value == true) {
                getAllProject();
                Navigator.pop(context);
              }
            });
          },
          child: const Text(
            "Remove",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
