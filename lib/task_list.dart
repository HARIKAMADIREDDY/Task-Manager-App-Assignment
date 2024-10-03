import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_assignment/taskcontroller.dart';
import 'package:task_manager_app_assignment/taskmodel.dart';
class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text('${task.description}\nPriority: ${task.priority}'),
                    onTap: () => _showEditTaskDialog(context, index),
                  );
                },
              );
            }),
          ),
          // Inside TaskListScreen widget, replace the ElevatedButton with one of the alternatives
TextButton(
  onPressed: () => _showAddTaskDialog(context),
  child: Text('Add Task'),
  style: TextButton.styleFrom(
  //  primary: Colors.blue, // Text color
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    textStyle: TextStyle(fontSize: 14),
  ),
),

        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String title = '';
    String? description;
    String priority = 'Medium';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Task Description (optional)'),
                onChanged: (value) => description = value,
                maxLines: 3,
              ),
              DropdownButton<String>(
                value: priority,
                onChanged: (value) {
                  if (value != null) priority = value;
                },
                items: ['High', 'Medium', 'Low']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  taskController.addTask(Task(title: title, description: description, priority: priority));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, int index) {
    final task = taskController.tasks[index];
    String title = task.title;
    String? description = task.description;
    String priority = task.priority;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onChanged: (value) => title = value,
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Task Description (optional)'),
                onChanged: (value) => description = value,
                controller: TextEditingController(text: description),
                maxLines: 3,
              ),
              DropdownButton<String>(
                value: priority,
                onChanged: (value) {
                  if (value != null) priority = value;
                },
                items: ['High', 'Medium', 'Low']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  taskController.editTask(index, Task(title: title, description: description, priority: priority));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                taskController.deleteTask(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
