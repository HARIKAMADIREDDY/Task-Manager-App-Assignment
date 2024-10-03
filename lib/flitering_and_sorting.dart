// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Task Manager',
//       home: TaskListScreen(),
//     );
//   }
// }

// class Task {
//   String title;
//   String? description;
//   String priority;

//   Task({required this.title, this.description, required this.priority});
// }

// class TaskController extends GetxController {
//   var tasks = <Task>[].obs;

//   void addTask(Task task) {
//     tasks.add(task);
//   }

//   void editTask(int index, Task updatedTask) {
//     tasks[index] = updatedTask;
//   }

//   void deleteTask(int index) {
//     tasks.removeAt(index);
//   }

//   List<Task> getTasksByPriority(String priority) {
//     return tasks.where((task) => task.priority == priority).toList();
//   }
// }

// class TaskListScreen extends StatelessWidget {
//   final TaskController taskController = Get.put(TaskController());
//   final RxString selectedPriority = 'All'.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Task Manager App')),
//       body: Column(
//         children: [
//           Obx(() => DropdownButton<String>(
//                 value: selectedPriority.value,
//                 onChanged: (value) {
//                   if (value != null) {
//                     selectedPriority.value = value; // Update the reactive variable
//                   }
//                 },
//                 items: ['All', 'High', 'Medium', 'Low']
//                     .map((label) => DropdownMenuItem(
//                           value: label,
//                           child: Text(label),
//                         ))
//                     .toList(),
//               )),
//           Expanded(
//             child: Obx(() {
//               var filteredTasks = selectedPriority.value == 'All'
//                   ? taskController.tasks
//                   : taskController.getTasksByPriority(selectedPriority.value);

//               return ListView.builder(
//                 itemCount: filteredTasks.length,
//                 itemBuilder: (context, index) {
//                   final task = filteredTasks[index];

//                   // Set the color based on task priority
//                   Color priorityColor;
//                   switch (task.priority) {
//                     case 'High':
//                       priorityColor = Colors.red;
                      
//                       break;
//                     case 'Medium':
//                       priorityColor = Colors.blue;
//                       break;
//                     case 'Low':
//                       priorityColor = Colors.green;
//                       break;
//                     default:
//                       priorityColor = Colors.black; // Fallback color
//                   }

//                   return ListTile(
//                     title: Text(
//                       task.title,
//                       style: TextStyle(color: priorityColor), // Apply the color
//                     ),
//                     subtitle: Text(
//                       '${task.description ?? "No description"}\nPriority: ${task.priority}',
//                       style: TextStyle(color: priorityColor), // Apply the color
//                     ),
//                     onTap: () => _showEditTaskDialog(context, index),
//                   );
//                 },
//               );
//             }),
//           ),
//          // Inside TaskListScreen widget, replace the ElevatedButton with one of the alternatives
// TextButton(
//   onPressed: () => _showAddTaskDialog(context),
//   child: Text('Add Task'),
//   style: TextButton.styleFrom(
//    // primary: Colors.blue, // Text color
//     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
//     textStyle: TextStyle(fontSize: 18),
//   ),
// ),

//         ],
//       ),
//     );
//   }

//   void _showAddTaskDialog(BuildContext context) {
//     String title = '';
//     String? description;
//     String priority = 'Medium';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Task'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Task Title'),
//                 onChanged: (value) => title = value,
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Task Description (optional)'),
//                 onChanged: (value) => description = value,
//                 maxLines: 3,
//               ),
//               DropdownButton<String>(
//                 value: priority,
//                 onChanged: (value) {
//                   if (value != null) priority = value;
//                 },
//                 items: ['High', 'Medium', 'Low']
//                     .map((label) => DropdownMenuItem(
//                           value: label,
//                           child: Text(label),
//                         ))
//                     .toList(),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (title.isNotEmpty) {
//                   taskController.addTask(Task(title: title, description: description, priority: priority));
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditTaskDialog(BuildContext context, int index) {
//     final task = taskController.tasks[index];
//     String title = task.title;
//     String? description = task.description;
//     String priority = task.priority;

//     // Create controllers for the text fields
//     TextEditingController titleController = TextEditingController(text: title);
//     TextEditingController descriptionController = TextEditingController(text: description ?? '');

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Task'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Task Title'),
//                 onChanged: (value) => title = value,
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Task Description (optional)'),
//                 onChanged: (value) => description = value,
//                 maxLines: 3,
//               ),
//               DropdownButton<String>(
//                 value: priority,
//                 onChanged: (value) {
//                   if (value != null) priority = value;
//                 },
//                 items: ['High', 'Medium', 'Low']
//                     .map((label) => DropdownMenuItem(
//                           value: label,
//                           child: Text(label),
//                         ))
//                     .toList(),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (title.isNotEmpty) {
//                   taskController.editTask(index, Task(title: title, description: description, priority: priority));
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Update'),
//             ),
//             TextButton(
//               onPressed: () {
//                 taskController.deleteTask(index);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
