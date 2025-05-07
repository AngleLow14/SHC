import 'package:flutter/material.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://djojicfdvwwgghliwnbp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqb2ppY2Zkdnd3Z2dobGl3bmJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwNDU1NjgsImV4cCI6MjA2MDYyMTU2OH0.CiUrrNRxj4T3M0H22jyrzS6i-Qh0hpLGGQophlw7-AM',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPC Social Hygiene Clinic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AdminLoginPage(),
    );
  }
}