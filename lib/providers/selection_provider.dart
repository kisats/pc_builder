import 'package:flutter/material.dart';

class SelectionProvider extends ChangeNotifier{

  TextEditingController textController;
  FocusNode focus;
  ScrollController scroll;

  List get components => null;

  List get filtered => null;

  bool isLoading;

  search() {}

  applyFilter(dynamic filter) {}

}