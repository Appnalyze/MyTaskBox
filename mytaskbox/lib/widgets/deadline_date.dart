import 'package:flutter/material.dart';

class DeadlineDate extends StatefulWidget {
  const DeadlineDate({super.key});

  @override
  State<DeadlineDate> createState() => _DeadlineDateState();
}

class _DeadlineDateState extends State<DeadlineDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
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
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month),
                  ),
                  Text("No selected date!", style: TextStyle(color: const Color.fromARGB(255, 122, 122, 122)),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
