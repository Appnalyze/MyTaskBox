import 'package:flutter/material.dart';

class TitleField extends StatefulWidget {
  const TitleField({super.key});

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          SizedBox(height: 8,),
          TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
