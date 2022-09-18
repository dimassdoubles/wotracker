import 'package:flutter/material.dart';
import 'package:wotracker/injection.dart' as injection;
import 'package:wotracker/presentation/pages/home_page.dart';
import 'package:wotracker/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
