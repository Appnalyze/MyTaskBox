import 'package:flutter/material.dart';
import 'package:mytaskbox/widgets/category_list.dart';
import 'package:mytaskbox/widgets/deadline_date.dart';
import 'package:mytaskbox/widgets/description_field.dart';
import 'package:mytaskbox/widgets/priority_list.dart';
import 'package:mytaskbox/widgets/style_button.dart';
import 'package:mytaskbox/widgets/title_field.dart';
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
    if (_selectedPriority == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a priority')));
      return;
    }
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter title and description')),
      );
      return;
    }
    final response = await Supabase.instance.client.from('tasks').insert({
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

    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedPriority = null;
      _selectedCategory = null;
      _selectedDeadline = null;
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
