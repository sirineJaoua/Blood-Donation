import 'package:flutter/material.dart';
import 'FirstScreen.dart';
import 'data.dart';
import 'package:provider/provider.dart';
import 'Approve.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BloodOrderProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MaterialApp(
        home: const FirstScreen(),
      ),
    );
  }
}
