import 'package:flutter/cupertino.dart';

class AlgorithmSelectionProvider extends ChangeNotifier {
  WeightageAlgorithms selectedWeightageAlgorithm;
  DecisionMakingAlgorithms selectedDecisionAlgorithm;

  List<WeightageAlgorithms> availableWeightageAlgorithms;
  List<DecisionMakingAlgorithms> availableDecisionMakingAlgorithms;

  AlgorithmSelectionProvider() {
    selectedWeightageAlgorithm = WeightageAlgorithms.bestWorst;
    selectedDecisionAlgorithm = DecisionMakingAlgorithms.topsis;

    availableWeightageAlgorithms = [
      WeightageAlgorithms.bestWorst,
      WeightageAlgorithms.ranking,
      WeightageAlgorithms.smart
    ];
    availableDecisionMakingAlgorithms = [
      DecisionMakingAlgorithms.topsis,
      DecisionMakingAlgorithms.wsm,
      DecisionMakingAlgorithms.vikor
    ];
  }

  selectWeightageAlgorithm(WeightageAlgorithms algorithm) {
    selectedWeightageAlgorithm = algorithm;
    notifyListeners();
  }

  selectDecisionAlgorithm(DecisionMakingAlgorithms algorithm) {
    selectedDecisionAlgorithm = algorithm;
    notifyListeners();
  }
}

enum WeightageAlgorithms { bestWorst, ranking, smart }

enum DecisionMakingAlgorithms { topsis, wsm, vikor }
