import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytaskbox/model/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final supabase = Supabase.instance.client;
  List<Task> tasks = [];
  bool isLoading = true;
  String _sortBy = 'deadline';

  @override
  void initState() {
    super.initState();
    getTaskStream();
  }

  Stream<List<Task>> getTaskStream() {
    final stream = supabase
        .from('task')
        .stream(primaryKey: ['id'])
        .eq('done', false)
        .order(_sortBy);

    return stream.map(
      (data) => data.map<Task>((json) => Task.fromJson(json)).toList(),
    );
  }

  Future<void> _toggleDone(Task task) async {
    final updated = !(task.done ?? false);
    final response = await supabase
        .from('task')
        .update({'done': updated})
        .eq('id', task.id)
        .select();
    print('Update response: $response');
    setState(() {
      getTaskStream();
    });();
  }

  Future<void> _confirmAndDelete(int taskId) async {
    final confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await supabase.from('task').delete().eq('id', taskId);
      getTaskStream();
    }
  }

  void _sortTasks() {
    if (_sortBy == 'deadline') {
      tasks.sort(
        (a, b) => (a.deadline ?? DateTime(2100)).compareTo(
          b.deadline ?? DateTime(2100),
        ),
      );
    } else if (_sortBy == 'priority') {
      final priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3};
      tasks.sort(
        (a, b) => (priorityOrder[a.priority] ?? 99).compareTo(
          priorityOrder[b.priority] ?? 99,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Container(height: 162, width: 300, color: Colors.blue),
        SizedBox(height: 15),
        Container(height: 85, width: 300, color: Colors.blue),
        SizedBox(height: 15),
        _buildSortDropdown(),
        Expanded(
          child: StreamBuilder<List<Task>>(
            stream: getTaskStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final liveTasks = snapshot.data!;
              return liveTasks.isEmpty
                  ? const Center(child: Text("No tasks found.", style: TextStyle(color: Colors.black, fontSize: 20),))
                  : ListView.builder(
                      itemCount: liveTasks.length,
                      itemBuilder: (context, index) {
                        final task = liveTasks[index];
                        return buildTaskCard(task);
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    return DropdownButton<String>(
      value: _sortBy,
      onChanged: (value) {
        setState(() {
          _sortBy = value!;
          _sortTasks();
        });
      },
      items: const [
        DropdownMenuItem(value: 'deadline', child: Text('Sort by Deadline')),
        DropdownMenuItem(value: 'priority', child: Text('Sort by Priority')),
      ],
    );
  }

  Widget buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
              } else if (value == 'delete') {
                _confirmAndDelete(task.id);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
          leading: InkWell(
            onTap: () => _toggleDone(task),
            child: Icon(
              task.done == true
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.done == true ? Colors.green : Colors.grey,
            ),
          ),
          title: Text(
            task.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              if (task.category != null) Text("Category: ${task.category}"),
              if (task.deadline != null)
                Text(
                  "Deadline: ${DateFormat.yMMMd().format(task.deadline!.toLocal())}",
                ),
              if (task.priority != null) Text("Priority: ${task.priority}"),
            ],
          ),
        ),
      ),
    );
  }
}
