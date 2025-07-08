import 'package:flutter/material.dart';

class StyleButton extends StatelessWidget {
  const StyleButton({super.key, required this.onPressed, this.label = 'Save Task'});

  final Future<void> Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.black38,
              offset: Offset(0, 3),
              blurRadius: 4,
              blurStyle: BlurStyle.normal
            )
          ]
        ),
        child: TextButton(
          onPressed: () async {
            await onPressed();
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
