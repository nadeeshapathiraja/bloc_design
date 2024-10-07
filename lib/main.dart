import 'package:bloc_patterns/theme/theme.dart';
import 'package:bloc_patterns/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'views/task_app/task_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme:
                Provider.of<ThemeProvider>(context, listen: false).getThemeMode,
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(
            //     seedColor: Colors.deepPurple,
            //     background: Colors.deepPurple,
            //   ),
            //   useMaterial3: true,
            // ),
            darkTheme: darkMode,
            home: const TaskApp(),
          );
        },
      ),
    );
  }
}
