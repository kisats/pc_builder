import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier{

  bool get canBeOpened => false;

  bool wasApplied;

  bool get hasChanged => false;
  bool get canClear => false;

  dynamic get currentFilter => null;

  applyFilter() {}

  clearFilter() {}

  generateFilter(List list){}

  setSortOrder() {}
}