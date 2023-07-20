import 'package:flutter/material.dart';
import 'package:proj4_flutter/controllers/task_controllers.dart';
import 'package:proj4_flutter/models/project.dart';
import 'package:proj4_flutter/models/task.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

import 'home_screen.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.task});
  final Task task;
  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
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

  @override
  void initState() {
    super.initState();
    taskName = TextEditingController(text: "${widget.task.taskName}");
    description =
        TextEditingController(text: "${widget.task.description ?? ""}");
    brief = TextEditingController(text: "${widget.task.brief}");
    priority = TextEditingController(text: "${widget.task.priority}");
    category = TextEditingController(text: "${widget.task.category}");
    status = TextEditingController(text: "${widget.task.status}");
    estimated = TextEditingController(text: "${widget.task.estimated}");
    actual = TextEditingController(text: "${widget.task.actualHours}");
    startDate = TextEditingController(text: "${widget.task.startDate}");
    endDate = TextEditingController(text: "${widget.task.endDate}");
    dueDate = TextEditingController(text: "${widget.task.dueDate}");
    assignee = TextEditingController(text: "${widget.task.user?.username}");
    parentTask = TextEditingController(text: "${widget.task.parentTask}");
  }

  @override
  void dispose() {
    taskName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(APP_PAGE.taskDetail.toTitle),
      ),
      body: SingleChildScrollView(
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priority,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Priority",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: category,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Category",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: status,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Status",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: estimated,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Estimated hours",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: dueDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Due date",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: startDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Start date",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: endDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "End date",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: assignee,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Assignee",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: parentTask,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Parent task",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: brief,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Task brief",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
                      taskUpdated.startDate = startDate.text;
                      taskUpdated.endDate = endDate.text;
                      taskUpdated.dueDate = dueDate.text;
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
                            builder: (context) => HomeScreen(),
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
    );
  }
}
