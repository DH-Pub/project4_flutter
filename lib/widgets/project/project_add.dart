import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/project_controllers.dart';

class ProjectAdd extends StatefulWidget {
  final Function getAllProjects;
  const ProjectAdd({super.key, required this.getAllProjects});

  @override
  State<ProjectAdd> createState() => _ProjectAddState();
}

class _ProjectAddState extends State<ProjectAdd> {
  ProjectController projectController = ProjectController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter Project Name",
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Enter Description",
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed:
              nameController.text == '' || descriptionController.text == ''
                  ? null
                  : () {
                      projectController
                          .addProject(
                              nameController.text, descriptionController.text)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            nameController.text = '';
                            descriptionController.text = '';
                          });
                          widget.getAllProjects();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                projectController.errMsg ?? "",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        }
                      });
                    },
          child: const Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
