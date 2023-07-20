import 'package:flutter/material.dart';
import 'package:proj4_flutter/models/project.dart';

class ProjectList extends StatelessWidget {
  final bool hasAuth;
  final ProjectDetail currentProject;
  final List<ProjectDetail> projects;
  final Function showRemoveDialog;
  const ProjectList(
      {super.key,
      required this.projects,
      required this.showRemoveDialog,
      required this.hasAuth,
      required this.currentProject});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          ProjectDetail prj = projects[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        prj.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(prj.name),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      showRemoveDialog(context, prj);
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
