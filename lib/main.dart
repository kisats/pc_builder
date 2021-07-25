/* import 'package:firedart/firestore/firestore.dart'; */
import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
/*   Firestore.initialize("pcbuilder-24b23"); */
  FireStore().initialize();
  runApp(MyApp());
}