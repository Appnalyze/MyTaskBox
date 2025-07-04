import 'package:flutter/material.dart';

class PriorityList extends StatefulWidget {
  const PriorityList({super.key});

  @override
  State<PriorityList> createState() => _PriorityListState();
}

class _PriorityListState extends State<PriorityList> {

  
  final List<Map<String, dynamic>> priorities = [
    {"name": 'High', "color": Colors.red},
    {"name": 'Medium', "color": Colors.yellow},
    {"name": 'Low', "color": Colors.green},
  ];

  int? _isSelectedPriority;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            "Set Priority",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Row(
            children: List.generate(priorities.length, (index) {
              final priority = priorities[index];
              final isSelected = _isSelectedPriority == index;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelectedPriority = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? priority["color"]
                          : const Color.fromARGB(255, 101, 183, 251),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      priority["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
