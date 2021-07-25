import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/logic/best_worst_method_logic.dart';

class BWAutoBuildProvider extends ChangeNotifier {
  BestWorstMethodLogic _bwLogic;

  BWAutoBuildProvider() {
    _bwLogic = BestWorstMethodLogic();
  }

  BestWorstValues bestValues, worstValues;

  generateWeights(){
    return _bwLogic.countWeights(bestValues, worstValues);
  }

  setBestParameters(BestWorstValues values) {
    bestValues = values;
    notifyListeners();
  }

  setWorstParameters(BestWorstValues values) {
    worstValues = values;
    notifyListeners();
  }
}

