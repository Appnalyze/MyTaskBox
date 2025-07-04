import 'package:flutter/material.dart';
import 'package:mytaskbox/color/colors_const.dart';
import 'package:mytaskbox/widgets/category_list.dart';
import 'package:mytaskbox/widgets/descriptioen_field.dart';
import 'package:mytaskbox/widgets/priority_list.dart';
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
          Container(
            height: 75,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Deadline",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
          PriorityList(),
          SizedBox(height: 40),
          Center(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                color: iconFocus,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Save Task",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
