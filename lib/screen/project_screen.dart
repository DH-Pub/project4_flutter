import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/project_controllers.dart';
import 'package:proj4_flutter/models/project.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';
import 'package:proj4_flutter/widgets/project/project_add.dart';
import 'package:proj4_flutter/widgets/project/project_list.dart';
import 'package:proj4_flutter/widgets/project/remove_project_alert.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  ProjectController projectController = ProjectController();
  ProjectDetail currentProject = ProjectDetail('', '', '', '');
  bool hasAuth = false;
  Widget mainContent = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  );

  Future<void> _showRemoveDialog(
    context,
    ProjectDetail prj,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return RemoveProjectAlert(getAllProject: getAllProject, prj: prj);
      },
    );
  }

  void getAllProject() async {
    projectController.getAllProjects().then((value) {
      if (value == null) {
        mainContent = const Text(
          "Error",
          style: TextStyle(color: Colors.red),
        );
      } else {
        mainContent = ProjectList(
          projects: value,
          showRemoveDialog: _showRemoveDialog,
          hasAuth: hasAuth,
          currentProject: currentProject,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(APP_PAGE.projects.toTitle),
        ),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ProjectAdd(getAllProjects: getAllProject),
              const SizedBox(height: 20),
              Expanded(
                child: mainContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
