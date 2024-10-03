import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Correct import
import 'package:task_manager_app_assignment/taskmodel.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  final GetStorage storage = GetStorage(); // Use GetStorage

  @override
  void onInit() {
    super.onInit();
    loadTasks(); // Load tasks from storage when the controller initializes
  }

  void loadTasks() {
    List<dynamic> storedTasks = storage.read('tasks') ?? [];
    tasks.value = storedTasks.map((task) => Task(
      title: task['title'],
      description: task['description'],
      priority: task['priority'],
    )).toList();
    sortTasks(); // Sort tasks after loading
  }

  void saveTasks() {
    List<Map<String, dynamic>> taskList = tasks.map((task) => {
      'title': task.title,
      'description': task.description,
      'priority': task.priority,
    }).toList();
    storage.write('tasks', taskList); // Save tasks to storage
  }

  void addTask(Task task) {
    tasks.add(task);
    sortTasks(); // Sort after adding
    saveTasks(); // Save to storage
  }

  void editTask(int index, Task updatedTask) {
    tasks[index] = updatedTask;
    sortTasks(); // Sort after editing
    saveTasks(); // Save to storage
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    sortTasks(); // Sort after deleting
    saveTasks(); // Save to storage
  }

  List<Task> getTasksByPriority(String priority) {
    return tasks.where((task) => task.priority == priority).toList();
  }

  void sortTasks() {
    tasks.sort((a, b) {
      return priorityOrder(a.priority).compareTo(priorityOrder(b.priority));
    });
  }

  int priorityOrder(String priority) {
    switch (priority) {
      case 'High':
        return 1;
      case 'Medium':
        return 2;
      case 'Low':
        return 3;
      default:
        return 4; // Fallback for unknown priority
    }
  }
}
