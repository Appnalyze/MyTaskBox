import 'package:flutter/material.dart';
import 'package:mytaskbox/my_tasks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hwakfkrucxrolgzlbjih.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3YWtma3J1Y3hyb2xnemxiamloIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0OTUzNzg4NSwiZXhwIjoyMDY1MTEzODg1fQ.OoKL8S_ekdPIy_Rz_8C1ZskohxZVCvpBRWs2MiS6iR0'
  );
  runApp(const MyApp()) ;
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My task box',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: MyTasks()
    );
  }
}
