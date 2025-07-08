import 'package:flutter/material.dart';

class DescriptioenField extends StatefulWidget {
  const DescriptioenField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<DescriptioenField> createState() => _DescriptioenFieldState();
}

class _DescriptioenFieldState extends State<DescriptioenField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          SizedBox(height: 8,),
          TextField(
            controller: widget.controller,
            maxLength: 150,
            maxLines: 4,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              label: Text(
                'Enter Description here...',
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
