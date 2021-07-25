import 'package:flutter/cupertino.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:darq/darq.dart';

class SmartAutobuildProvider extends ChangeNotifier {
  List<ComputerParameter> computerParams;

  List<Criteria> criterias;

  ComputerParameter bestCriteria, worstCriteria;

  bool get isDisabled =>
      bestCriteria == ComputerParameter.none ||
      bestCriteria == null ||
      worstCriteria == ComputerParameter.none ||
      worstCriteria == null;

  SmartAutobuildProvider() {
    computerParams = [
      ComputerParameter.none,
      ComputerParameter.gaming,
      ComputerParameter.contentCreation,
      ComputerParameter.multitasking,
      ComputerParameter.price,
      ComputerParameter.storage,
      ComputerParameter.consumption
    ];
    _generateCriterias();
    bestCriteria = ComputerParameter.none;
    worstCriteria = ComputerParameter.none;
  }

  _generateCriterias() {
    criterias = [
      Criteria(ComputerParameter.price, 10, "Price"),
      Criteria(ComputerParameter.gaming, 10, "Gaming perfermance"),
      Criteria(ComputerParameter.contentCreation, 10, "Content Creation"),
      Criteria(ComputerParameter.multitasking, 10, "Multitasking"),
      Criteria(ComputerParameter.storage, 10, "Storage"),
      Criteria(ComputerParameter.consumption, 10, "Consumption"),
    ];
  }

  setBestCritera(ComputerParameter criteria) {
    bestCriteria = criteria;
    _generateCriterias();
    criterias.removeWhere((e) => e.criteria == bestCriteria);
    if (worstCriteria != null || worstCriteria != ComputerParameter.none)
      criterias.removeWhere((e) => e.criteria == worstCriteria);
    notifyListeners();
  }

  setWorstCritera(ComputerParameter criteria) {
    worstCriteria = criteria;
    _generateCriterias();
    criterias.removeWhere((e) => e.criteria == worstCriteria);
    if (bestCriteria != null || bestCriteria != ComputerParameter.none)
      criterias.removeWhere((e) => e.criteria == bestCriteria);
    notifyListeners();
  }

  setCriteriaValue(ComputerParameter criteria, int value) {
    criterias.firstWhere((e) => e.criteria == criteria).value = value;
    notifyListeners();
  }

  generateWeights() {
    criterias.add(Criteria(bestCriteria, 100, ""));
    criterias.add(Criteria(worstCriteria, 10, ""));

    var sum = criterias.sum((c) => c.value);
    for (var criteria in criterias) {
      criteria.weight = criteria.value / sum;
    }

    return BuildWeights(
        criterias.firstWhere((e) => e.criteria == ComputerParameter.price).weight,
        criterias.firstWhere((e) => e.criteria == ComputerParameter.gaming).weight,
        criterias.firstWhere((e) => e.criteria == ComputerParameter.consumption).weight,
        criterias.firstWhere((e) => e.criteria == ComputerParameter.contentCreation).weight,
        criterias.firstWhere((e) => e.criteria == ComputerParameter.storage).weight,
        criterias.firstWhere((e) => e.criteria == ComputerParameter.multitasking).weight,
        null);
  }

  int criteriaValue(ComputerParameter param) {
    return criterias
            .firstWhere(
              (e) => e.criteria == param,
              orElse: () => null,
            )
            ?.value ??
        1;
  }
}
