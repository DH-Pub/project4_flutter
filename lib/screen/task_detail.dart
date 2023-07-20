import 'package:flutter/material.dart';
import 'package:proj4_flutter/models/task.dart';
import 'package:proj4_flutter/routes/route_utils.dart';

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

  @override
  void initState() {
    super.initState();
    taskName = TextEditingController(text: "${widget.task.taskName}");
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
      body: Padding(
        padding: EdgeInsets.all(20),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
