import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/task_controllers.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/project.dart';
import 'package:proj4_flutter/models/task.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/models/user.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

import 'home_screen.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.task});
  final Task task;
  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  TeamController teamController = TeamController();
  late TextEditingController taskName;
  late TextEditingController description;
  late TextEditingController brief;
  late TextEditingController priority;
  late TextEditingController category;
  late TextEditingController status;
  late TextEditingController estimated;
  late TextEditingController actual;
  late TextEditingController startDate;
  late TextEditingController endDate;
  late TextEditingController dueDate;
  late TextEditingController assignee;
  late TextEditingController parentTask;
  String? selectedPriority;
  List<String> lstPriority = ["HIGH", "NORMAL", "LOW"];
  String? selectedCategory;
  List<String> lstCategory = ["TASK", "BUG", "CR"];
  String? selectedStatus;
  List<String> lstStatus = ["IN PROGRESS", "OPEN", "RESOLVED", "CLOSED"];
  String? selectedUser;
  List<TeamMemberDetail> lstUser = [];

  List<TeamMemberDetail>? allTeamMembers = [];

  Future getAllMembers() async {
    allTeamMembers = await teamController.getAllMembersDetails();
  }

  @override
  void initState() {
    super.initState();
    taskName = TextEditingController(text: "${widget.task.taskName}");
    description = TextEditingController(text: widget.task.description ?? "");
    brief = TextEditingController(text: widget.task.brief ?? "");
    priority = TextEditingController(text: "${widget.task.priority}");
    category = TextEditingController(text: "${widget.task.category}");
    status = TextEditingController(text: "${widget.task.status}");
    estimated = TextEditingController(text: "${widget.task.estimated}");
    actual = TextEditingController(text: "${widget.task.actualHours}");
    startDate = TextEditingController(text: widget.task.startDate ?? "");
    endDate = TextEditingController(text: widget.task.endDate ?? "");
    dueDate = TextEditingController(text: widget.task.dueDate ?? "");
    assignee = TextEditingController(text: "${widget.task.user?.username}");
    parentTask = TextEditingController(text: widget.task.parentTask ?? "");
    // teamController.initPrefs().then((_) {
    //   teamController.getAllMembersDetails().then((members) {
    //     for (var member in members!) {
    //       lstUser.add(member);
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    taskName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> userEntries =
        <DropdownMenuEntry<String>>[];
    teamController.initPrefs().then((_) {
      teamController.getAllMembersDetails().then((members) {
        for (var member in members!) {
          lstUser.add(member);
        }
        for (final TeamMemberDetail user in lstUser) {
          userEntries.add(
            DropdownMenuEntry<String>(value: user.userId, label: user.username),
          );
        }
      });
    });
    final List<DropdownMenuEntry<String>> priorityEntries =
        <DropdownMenuEntry<String>>[];
    for (final String priority in lstPriority) {
      priorityEntries.add(
        DropdownMenuEntry<String>(value: priority, label: priority),
      );
    }
    final List<DropdownMenuEntry<String>> categoryEntries =
        <DropdownMenuEntry<String>>[];
    for (final String category in lstCategory) {
      categoryEntries.add(
        DropdownMenuEntry<String>(value: category, label: category),
      );
    }
    final List<DropdownMenuEntry<String>> statusEntries =
        <DropdownMenuEntry<String>>[];
    for (final String status in lstStatus) {
      statusEntries.add(
        DropdownMenuEntry<String>(value: status, label: status),
      );
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(APP_PAGE.taskDetail.toTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
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
                  "PROJECT: ${widget.task.project?.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: taskName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Task name",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              child: DropdownMenu(
                                menuStyle: const MenuStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                controller: priority,
                                label: const Text('Priority'),
                                dropdownMenuEntries: priorityEntries,
                                onSelected: (String? selectedPriority) {
                                  setState(() {
                                    selectedPriority = selectedPriority;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              child: DropdownMenu(
                                menuStyle: const MenuStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                controller: category,
                                label: const Text('Category'),
                                dropdownMenuEntries: categoryEntries,
                                onSelected: (String? selectedCategory) {
                                  setState(() {
                                    selectedCategory = selectedCategory;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              child: DropdownMenu(
                                menuStyle: const MenuStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                controller: status,
                                label: const Text('Status'),
                                dropdownMenuEntries: statusEntries,
                                onSelected: (String? selectedStatus) {
                                  setState(() {
                                    selectedStatus = selectedStatus;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              child: DropdownMenu(
                                menuStyle: const MenuStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                controller: assignee,
                                label: const Text('Assignee'),
                                dropdownMenuEntries: userEntries,
                                onSelected: (String? selectedUser) {
                                  setState(() {
                                    selectedUser = selectedUser;
                                  });
                                  widget.task.user?.id = selectedUser!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          // width: 110,
                          child: TextFormField(
                            controller: estimated,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Estimated hours",
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          // width: 50,
                          child: TextFormField(
                            controller: actual,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Actual hours",
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: dueDate,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Due date",
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: startDate,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Start date",
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: endDate,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "End date",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Project project = Project();
                              project.id = "1689772797132";
                              Task taskUpdated = Task();
                              taskUpdated.id = widget.task.id;
                              taskUpdated.taskName = taskName.text;
                              taskUpdated.description = description.text;
                              taskUpdated.brief = brief.text;
                              taskUpdated.priority = priority.text;
                              taskUpdated.category = category.text;
                              taskUpdated.status = status.text;
                              taskUpdated.estimated = int.parse(estimated.text);
                              taskUpdated.actualHours = int.parse(actual.text);
                              taskUpdated.startDate =
                                  startDate.text == "" ? null : startDate.text;
                              taskUpdated.endDate =
                                  endDate.text == "" ? null : endDate.text;
                              taskUpdated.dueDate =
                                  dueDate.text == "" ? null : dueDate.text;
                              taskUpdated.user = widget.task.user;
                              taskUpdated.parentTask = parentTask.text;
                              taskUpdated.project = widget.task.project;
                              TaskController taskController = TaskController();
                              taskController
                                  .updateTask(taskUpdated.toJson())
                                  .then((response) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              }).catchError((err) {
                                print(err);
                              });
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
        ),
      ),
    );
  }
}
