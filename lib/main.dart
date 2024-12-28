import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view_model/to_do_view_model.dart';
import 'package:to_do_app/views/pages/To_do_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDoViewModel(),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: '/',
        routes: {
          "/": (context) => HomePage(),
        },
      ),
    );
  }
}