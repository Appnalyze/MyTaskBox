import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadTasksFromSupabase();
  }

  bool isLoading = false;

  // ⬇ Fetch from Supabase and build the events map
  Future<void> _loadTasksFromSupabase() async {
    setState(() => isLoading = true);
    final response = await Supabase.instance.client
        .from('task')
        .select('id, title, deadline');
    if (response.isEmpty) return;
    final Map<DateTime, List<Map<String, dynamic>>> loadedEvents = {};
    for (var task in response) {
      final id = task['id'];
      final deadlineString = task['deadline'];
      final title = task['title'];
      if (deadlineString != null && title != null) {
        final deadline = DateTime.parse(deadlineString);
        final dayKey = DateTime.utc(
          deadline.year,
          deadline.month,
          deadline.day,
        );
        final event = {'id': id, 'title': title, 'time': deadline};
        if (loadedEvents.containsKey(dayKey)) {
          loadedEvents[dayKey]!.add(event);
        } else {
          loadedEvents[dayKey] = [event];
        }
      }
    }
    setState(() {
      _events = loadedEvents;
      isLoading = false;
    });
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Task'),
            content: const Text('Are you sure you want to delete this task?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _deleteTask(int id) async {
    await Supabase.instance.client.from('task').delete().eq('id', id);

    _loadTasksFromSupabase(); // Refresh UI
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TableCalendar(
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(fontSize: 17),
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            DateFormat('EEEE, MMMM d, y').format(_selectedDay ?? _focusedDay),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "${_getEventsForDay(_selectedDay ?? _focusedDay).length} ${_getEventsForDay(_selectedDay ?? _focusedDay).length == 1 ? 'task' : 'tasks'}",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: selectedEvents.isEmpty
                ? const Center(
                    child: Text(
                      "No events for this day",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedEvents[index];
                      final timeFormatted = DateFormat(
                        'h:mm a',
                      ).format(event['time']);

                      return Dismissible(
                        key: ValueKey(event['id'] ?? UniqueKey()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) => _confirmDelete(context),
                        onDismissed: (_) async {
                          final id = event['id'];
                          setState(() {
                            selectedEvents.removeAt(index);
                          });
                          await _deleteTask(id);
                          },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.shade100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text(
                              timeFormatted,
                              style: const TextStyle(fontSize: 16),
                            ),
                            title: Text(
                              event['title'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
