import 'package:flutter/material.dart';
import 'package:mytaskbox/widgets/category_list.dart';
import 'package:mytaskbox/widgets/deadline_date.dart';
import 'package:mytaskbox/widgets/descriptioen_field.dart';
import 'package:mytaskbox/widgets/priority_list.dart';
import 'package:mytaskbox/widgets/style_button.dart';
import 'package:mytaskbox/widgets/title_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          TitleField(),
          DescriptioenField(),
          CategoryList(),
          DeadlineDate(),
          PriorityList(),
          SizedBox(height: 40),
          StyleButton()
        ],
      ),
    );
  }
}
