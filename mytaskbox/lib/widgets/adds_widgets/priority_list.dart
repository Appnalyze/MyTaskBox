import 'package:flutter/material.dart';

class PriorityList extends StatefulWidget {
  const PriorityList({
    super.key,
    this.onPrioritySelected,
    this.selectedPriority,
  });

  final void Function(String selectedPriority)? onPrioritySelected;
  final String? selectedPriority;

  static List<String> get defaultPriorities => ['High', 'Medium', 'Low'];

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
  void initState() {
    super.initState();

    if (widget.selectedPriority != null) {
      final initialIndex = priorities.indexWhere((p) =>
          p['name'].toString().toLowerCase() ==
          widget.selectedPriority!.toLowerCase());
      if (initialIndex != -1) {
        _isSelectedPriority = initialIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelectedPriority = index;
                    });
                    widget.onPrioritySelected?.call(priority['name']);
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
                      style: const TextStyle(
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
