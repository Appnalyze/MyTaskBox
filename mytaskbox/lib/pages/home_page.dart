import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Container(height: 162, width: 300, color: Colors.blue),
        SizedBox(height: 15),

        Container(height: 85, width: 300, color: Colors.blue),
        SizedBox(height: 15),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      color: Colors.amber,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      width: 200,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
