import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_helper.dart';

import 'note_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: NotesApp()),
    );
  }
}
