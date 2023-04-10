import 'package:flutter/material.dart';
import 'package:uesbvent/models/home_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/organizador_page.dart';

import 'models/membros_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
