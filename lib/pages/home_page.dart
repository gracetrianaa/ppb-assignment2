import 'package:flutter/material.dart';
import 'package:taskweekfour_todolist/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TaskModel> tasksList = [];

  void createTask({required TaskModel task}) {
    setState(() {
      tasksList.add(task);
    });
  }

  void updateTask({required String taskId, required String newTitle, required String status, required DateTime lastUpdated}) {
    final taskIndex = tasksList.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      setState(() {
        tasksList[taskIndex] = TaskModel(
          id: taskId,
          title: newTitle,
          status: status,
          lastUpdated: lastUpdated,
        );
      });
    }
  }

  void deleteTask({required String taskId}) {
    setState(() {
      tasksList.removeWhere((task) => task.id == taskId);
    });
  }

  final TextEditingController taskTextEditingController = TextEditingController();

  void showEditDialog(TaskModel task) {
    final TextEditingController editController = TextEditingController(text: task.title);
    String selectedStatus = task.status;
    DateTime lastUpdated = task.lastUpdated ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editController,
                    decoration: const InputDecoration(
                        labelText: 'Edit Task Title'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: ['Completed', 'In Progress', 'On Hold']
                        .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                        )).toList(),
                    onChanged: (value) {
                      if(value != null) {
                        setState(() {
                          selectedStatus = value;
                          lastUpdated = DateTime.now();
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Status',
                    ),
                  ),
                  if (selectedStatus != 'Completed') ...[
                    const SizedBox(height: 8),
                    Text(
                      'Last updated: ${lastUpdated.toString()}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ]
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    updateTask(
                      taskId: task.id,
                      newTitle: editController.text,
                      status: selectedStatus,
                      lastUpdated: lastUpdated,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Daily To-Do List'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Color(0xFFCE6C47),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: tasksList.isNotEmpty
        ? Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: tasksList.length,
                  itemBuilder: (context, index) {
                    final TaskModel task = tasksList[index];

                    return ListTile(
                      onTap: () => showEditDialog(task),

                      title: Text(
                        task.title, style: TextStyle(
                        color: task.status == 'Completed'
                            ? Colors.grey
                            : Colors.black,
                        decoration: task.status == 'Completed'
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 20,
                      ),
                      ),
                      subtitle: task.status != 'Completed'
                          ? Text(
                        'Last updated: ${task.lastUpdated?.toString()}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ) : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            task.status,
                            style: TextStyle(fontStyle: FontStyle.italic,
                              color: task.status == 'On Hold'
                                  ? Colors.orange
                                  : Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () => deleteTask(taskId: task.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.pinkAccent,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
            )
            )],
        )
        : const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'No tasks registered, click the + button',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Task'),
                content: TextField(
                  controller: taskTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Describe your task',
                  ),
                  maxLines: 2,
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (taskTextEditingController.text.isNotEmpty) {
                        final TaskModel newTask = TaskModel(
                          id: DateTime.now().toString(),
                          title: taskTextEditingController.text,
                          status: 'In Progress',
                          lastUpdated: DateTime.now(),
                        );

                        createTask(task: newTask);

                        taskTextEditingController.clear();

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }
}