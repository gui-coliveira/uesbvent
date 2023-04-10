import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(AppWidget());
}
