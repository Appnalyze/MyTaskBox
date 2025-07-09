import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytaskbox/color/colors_const.dart';
import 'package:mytaskbox/pages/home_page.dart';
import 'package:mytaskbox/pages/add_task_page.dart';
import 'package:mytaskbox/pages/calendar_page.dart';
import 'package:mytaskbox/pages/dashboard_page.dart';
import 'package:mytaskbox/pages/profile_page.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  
  State<MyTasks> createState() => _MyTasksState();
  
}

class _MyTasksState extends State<MyTasks> {
  int _selectedIndex = 0;

  
  final GlobalKey<CalendarPageState> _calendarKey = GlobalKey<CalendarPageState>();

  late final List _screens = [
    Homepage(),
    CalendarPage(key: _calendarKey,),
    Container(),
    DashboardPage(),
    ProfilePage(), 
  ];
  

  void _openAddExpenseOverlay() async {
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddTaskPage(),
    );

    _calendarKey.currentState?.refreshTasks(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: NavigationBar(
            backgroundColor: backGroundColor,
            surfaceTintColor: Colors.transparent,
            labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(color: iconFocus);
              }
              return TextStyle(color: const Color.fromARGB(255, 87, 87, 87));
            }),
            elevation: 0.0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              if (index == 2) {
                _openAddExpenseOverlay();
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            destinations: [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: iconFocus),
                icon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_month, color: iconFocus),
                icon: Icon(Icons.calendar_month),
                label: "Calendar",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: iconFocus,
                ),
                icon: Icon(CupertinoIcons.add_circled_solid),
                label: "Add",
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.dashboard, color: iconFocus),
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              NavigationDestination(
                selectedIcon: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('images/amor_y_luigi.jpeg'),
                ),
                icon: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('images/amor_y_luigi.jpeg'),
                ),
                label: "You",
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
    );
  }
}
