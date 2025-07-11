import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeadlineDate extends StatefulWidget {
  const DeadlineDate({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  final void Function(DateTime deadline)? onDateSelected;
  final DateTime? initialDate;

  @override
  State<DeadlineDate> createState() => _DeadlineDateState();
}

class _DeadlineDateState extends State<DeadlineDate> {
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDate;
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? now),
    );

    if (pickedTime == null) return;

    final DateTime fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDateTime = fullDateTime;
    });

    if (widget.onDateSelected != null) {
      widget.onDateSelected!(fullDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deadline",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _pickDateTime,
                    icon: const Icon(Icons.calendar_month),
                  ),
                  Text(
                    _selectedDateTime != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime!)
                        : "No selected date!",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
