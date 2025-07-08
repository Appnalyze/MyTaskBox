import 'package:flutter/material.dart';
import 'package:mytaskbox/widgets/adds_widgets/category_list.dart';
import 'package:mytaskbox/widgets/adds_widgets/deadline_date.dart';
import 'package:mytaskbox/widgets/adds_widgets/description_field.dart';
import 'package:mytaskbox/widgets/adds_widgets/priority_list.dart';
import 'package:mytaskbox/widgets/adds_widgets/style_button.dart';
import 'package:mytaskbox/widgets/adds_widgets/title_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedPriority;
  String? _selectedCategory;
  DateTime? _selectedDeadline;

  Future<void> _submitTask() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _selectedDeadline == null ||
        _selectedCategory == null ||
        _selectedPriority == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
            'Please make sure a valid title, description, date, priority and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    final response = await Supabase.instance.client.from('task').insert({
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'category': _selectedCategory,
      'deadline': _selectedDeadline?.toIso8601String(),
      'priority': _selectedPriority,
    });
    if (response != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task saved successfully')));
    }
    Navigator.pop(context);

    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedCategory = null;
      _selectedDeadline = null;
      _selectedPriority = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        TitleField(controller: _titleController),
        DescriptioenField(controller: _descriptionController),
        CategoryList(
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        ),
        DeadlineDate(
          onDateSelected: (pickDate) {
            setState(() {
              _selectedDeadline = pickDate;
            });
          },
        ),
        PriorityList(
          onPrioritySelected: (priority) {
            setState(() {
              _selectedPriority = priority;
            });
          },
        ),
        SizedBox(height: 40),
        StyleButton(onPressed: _submitTask),
      ],
    );
  }
}
