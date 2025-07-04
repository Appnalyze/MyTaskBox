import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          
        ),
         Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}