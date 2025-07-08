import 'package:flutter/material.dart';

class TitleField extends StatefulWidget {
  const TitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<TitleField> createState() => _TitleFieldState();


}

class _TitleFieldState extends State<TitleField> {
  
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Title",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, size: 25, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: widget.controller,
            decoration: InputDecoration(
              label: Text(
                'Enter Title',
                style: TextStyle(
                  color: const Color.fromARGB(255, 138, 138, 138),
                  fontSize: 20,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
