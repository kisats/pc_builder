import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FireStore().initialize();
  runApp(MyApp());
}
