import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/task_controllers.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/task.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/screen/task_detail.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Team team = Team('', '', '', '');
  late TeamController teamController = TeamController();
  late List<Task>? tasks = [];
  late List<Task>? renderTasks = [];
  late List<Task>? doingTasks = [];
  late List<Task>? openTasks = [];
  late List<Task>? resolvedTasks = [];
  late List<Task>? closedTasks = [];
  late Task task = Task();
  late TaskController taskController = TaskController();

  Future getAllTasks() async {
    tasks = await taskController.getAllTasks();
    setState(() {});
  }

  Future getTasksByUser(String userId, String projectId) async {
    tasks = await taskController.getTaskByUser(userId, projectId);
    setState(() {});
  }

  @override
  void initState() {
    String currentTeam;
    teamController.initPrefs().then((_) {
      currentTeam = teamController.getTeamInPrefs().id;
      getAllTasks().then((_) {
        for (Task task in tasks!) {
          if (task.project?.team?.id == currentTeam) {
            renderTasks!.add(task);
          }
        }
        for (var task in renderTasks!) {
          if (task.status == "IN PROGRESS") {
            doingTasks!.add(task);
          } else if (task.status == "OPEN") {
            openTasks!.add(task);
          } else if (task.status == "RESOLVED") {
            resolvedTasks!.add(task);
          } else {
            closedTasks!.add(task);
          }
        }
      });
    });
    // getAllTasks().then((_) {
    //   for (var task in tasks!) {
    //     if (task.status == "IN PROGRESS") {
    //       doingTasks!.add(task);
    //     } else if (task.status == "OPEN") {
    //       openTasks!.add(task);
    //     } else if (task.status == "RESOLVED") {
    //       resolvedTasks!.add(task);
    //     } else {
    //       closedTasks!.add(task);
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(APP_PAGE.home.toTitle),
      ),
      drawer: const MenuDrawer(),
      bottomNavigationBar: const MenuBottom(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.amber,
                    ),
                    child: Text(
                      "IN PROGRESS: ${doingTasks?.length} ${doingTasks!.length > 1 ? "tickets" : "ticket"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                            label: Text('Task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Priority',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Due Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                      ],
                      rows: List<DataRow>.generate(
                        doingTasks!.length,
                        (index) => DataRow(
                          selected: false,
                          onSelectChanged: (x) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetail(task: doingTasks![index]),
                              ),
                            )
                          },
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 130, //SET width
                                child: Text(
                                  "${doingTasks?[index].taskName}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 10, //SET width
                                child: Icon(
                                  doingTasks?[index].priority == "HIGH"
                                      ? Icons.arrow_upward
                                      : doingTasks?[index].priority == "NORMAL"
                                          ? Icons.arrow_forward
                                          : doingTasks?[index].priority == "LOW"
                                              ? Icons.arrow_downward
                                              : null,
                                  color: doingTasks?[index].priority == "HIGH"
                                      ? Colors.red
                                      : doingTasks?[index].priority == "NORMAL"
                                          ? Colors.blue
                                          : doingTasks?[index].priority == "LOW"
                                              ? Colors.green
                                              : null,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 35, //SET width
                                child: Text(
                                  "${doingTasks?[index].category}",
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80, //SET width
                                child: Text(
                                  doingTasks?[index].dueDate ?? "yyyy-MM-dd",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.green,
                    ),
                    child: Text(
                      "OPEN: ${openTasks?.length} ${openTasks!.length > 1 ? "tickets" : "ticket"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                            label: Text('Task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Priority',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Due Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                      ],
                      rows: List<DataRow>.generate(
                        openTasks!.length,
                        (index) => DataRow(
                          selected: false,
                          onSelectChanged: (x) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetail(task: openTasks![index]),
                              ),
                            )
                          },
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 130, //SET width
                                child: Text(
                                  "${openTasks?[index].taskName}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 10, //SET width
                                child: Icon(
                                  openTasks?[index].priority == "HIGH"
                                      ? Icons.arrow_upward
                                      : openTasks?[index].priority == "NORMAL"
                                          ? Icons.arrow_forward
                                          : openTasks?[index].priority == "LOW"
                                              ? Icons.arrow_downward
                                              : null,
                                  color: openTasks?[index].priority == "HIGH"
                                      ? Colors.red
                                      : openTasks?[index].priority == "NORMAL"
                                          ? Colors.blue
                                          : openTasks?[index].priority == "LOW"
                                              ? Colors.green
                                              : null,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 35, //SET width
                                child: Text(
                                  "${openTasks?[index].category}",
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80, //SET width
                                child: Text(
                                  openTasks?[index].dueDate ?? "yyyy-MM-dd",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                    ),
                    child: Text(
                      "RESOLVED: ${resolvedTasks?.length} ${resolvedTasks!.length > 1 ? "tickets" : "ticket"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                            label: Text('Task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Priority',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Due Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                      ],
                      rows: List<DataRow>.generate(
                        resolvedTasks!.length,
                        (index) => DataRow(
                          selected: false,
                          onSelectChanged: (x) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetail(task: resolvedTasks![index]),
                              ),
                            )
                          },
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 130, //SET width
                                child: Text(
                                  "${resolvedTasks?[index].taskName}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 10, //SET width
                                child: Icon(
                                  resolvedTasks?[index].priority == "HIGH"
                                      ? Icons.arrow_upward
                                      : resolvedTasks?[index].priority ==
                                              "NORMAL"
                                          ? Icons.arrow_forward
                                          : resolvedTasks?[index].priority ==
                                                  "LOW"
                                              ? Icons.arrow_downward
                                              : null,
                                  color: resolvedTasks?[index].priority ==
                                          "HIGH"
                                      ? Colors.red
                                      : resolvedTasks?[index].priority ==
                                              "NORMAL"
                                          ? Colors.blue
                                          : resolvedTasks?[index].priority ==
                                                  "LOW"
                                              ? Colors.green
                                              : null,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 35, //SET width
                                child: Text(
                                  "${resolvedTasks?[index].category}",
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80, //SET width
                                child: Text(
                                  resolvedTasks?[index].dueDate ?? "yyyy-MM-dd",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "CLOSED: ${closedTasks?.length} ${closedTasks!.length > 1 ? "tickets" : "ticket"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                            label: Text('Task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Priority',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                        DataColumn(
                            label: Text('Due Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                      ],
                      rows: List<DataRow>.generate(
                        closedTasks!.length,
                        (index) => DataRow(
                          selected: false,
                          onSelectChanged: (x) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetail(task: closedTasks![index]),
                              ),
                            )
                          },
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 130, //SET width
                                child: Text(
                                  "${closedTasks?[index].taskName}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 10, //SET width
                                child: Icon(
                                  closedTasks?[index].priority == "HIGH"
                                      ? Icons.arrow_upward
                                      : closedTasks?[index].priority == "NORMAL"
                                          ? Icons.arrow_forward
                                          : closedTasks?[index].priority ==
                                                  "LOW"
                                              ? Icons.arrow_downward
                                              : null,
                                  color: closedTasks?[index].priority == "HIGH"
                                      ? Colors.red
                                      : closedTasks?[index].priority == "NORMAL"
                                          ? Colors.blue
                                          : closedTasks?[index].priority ==
                                                  "LOW"
                                              ? Colors.green
                                              : null,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 35, //SET width
                                child: Text(
                                  "${closedTasks?[index].category}",
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80, //SET width
                                child: Text(
                                  closedTasks?[index].dueDate ?? "yyyy-MM-dd",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
