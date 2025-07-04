import 'package:flutter/material.dart';
import 'package:mytaskbox/color/colors_const.dart';

class StyleButton extends StatefulWidget {
  const StyleButton({super.key});

  @override
  State<StyleButton> createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: iconFocus,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.black26,
              offset: Offset(0, 3),
              blurRadius: 5,
              blurStyle: BlurStyle.normal
            )
          ]
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            "Save Task",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
