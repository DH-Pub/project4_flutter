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
  late List<Task>? doingTasks = [];
  late List<Task>? openTasks = [];
  late List<Task>? resolvedTasks = [];
  late List<Task>? closedTasks = [];
  late Task task = Task();
  late TaskController taskController = TaskController();

  Future getTeams() async {
    tasks = await taskController.getAllTasks();
    setState(() {});
  }

  Future getTasksByUser() async {
    tasks =
        await taskController.getTaskByUser("1687794987148", "1689557816372");
    setState(() {});
  }

  @override
  void initState() {
    // teamController.initPrefs().then((_) {
    //   team = teamController.getTeamInPrefs();
    //   setState(() {});
    // });
    getTasksByUser().then((_) {
      for (var task in tasks!) {
        if (task.status == "IN PROGRESS") {
          doingTasks!.add(task);
        } else if (task.status == "OPREN") {
          openTasks!.add(task);
        } else if (task.status == "RESOVED") {
          resolvedTasks!.add(task);
        } else {
          closedTasks!.add(task);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(APP_PAGE.home.toTitle),
      ),
      drawer: const MenuDrawer(),
      bottomNavigationBar: const MenuBottom(),
      body: Column(
        children: [
          const Row(
            children: [Text("IN PROGRESS")],
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
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(
                        label: Text('Priority',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(
                        label: Text('Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                    DataColumn(
                        label: Text('Due Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
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
                          Container(
                            width: 130, //SET width
                            child: Text(
                              "${doingTasks?[index].taskName}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
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
                          Container(
                            width: 35, //SET width
                            child: Text(
                              "${doingTasks?[index].category}",
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 80, //SET width
                            child: Text(
                              "${doingTasks?[index].dueDate}",
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
    );
  }
}
