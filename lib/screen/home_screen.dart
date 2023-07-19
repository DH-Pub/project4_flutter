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
      print(tasks.toString());
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
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(team.teamName),
        //   ],
        // ),
        body: SizedBox(
          child: DataTable(
            showCheckboxColumn: false,
            columnSpacing: 20,
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
              tasks!.length,
              (index) => DataRow(
                selected: false,
                onSelectChanged: (x) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetail(task: tasks![index]),
                    ),
                  )
                },
                cells: [
                  DataCell(
                    Container(
                      width: 130, //SET width
                      child: Text(
                        "${tasks?[index].taskName}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 60, //SET width
                      child: Text(
                        "${tasks?[index].priority}",
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 35, //SET width
                      child: Text(
                        "${tasks?[index].category}",
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 100, //SET width
                      child: Text(
                        "${tasks?[index].dueDate}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
