import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';

class WorstCriteriaSelectionProvider extends ChangeNotifier {
  AutoBuildProvider autobuildProvider;
  ComputerParameter bestCriteria;

  List<Criteria> criterias;

  List<ComputerParameter> computerParams;

  ComputerParameter worstCriteria;

  bool get isDisabled => bestCriteria == null || bestCriteria == ComputerParameter.none;

  WorstCriteriaSelectionProvider(this.autobuildProvider) {
    _generateCriterias();
    worstCriteria = ComputerParameter.none;
    bestCriteria = autobuildProvider.bestValues.mainParam;
    computerParams = [
      ComputerParameter.none,
      ComputerParameter.gaming,
      ComputerParameter.contentCreation,
      ComputerParameter.multitasking,
      ComputerParameter.price,
      ComputerParameter.storage,
      ComputerParameter.consumption
    ];
    computerParams.removeWhere((e) => e == bestCriteria);
  }

  setWorstCritera(ComputerParameter criteria) {
    worstCriteria = criteria;
    _generateCriterias();
    criterias.removeWhere((e) => e.criteria == worstCriteria);
    notifyListeners();
  }

  _generateCriterias() {
    criterias = [
      Criteria(ComputerParameter.price, 1, "Price"),
      Criteria(ComputerParameter.gaming, 1, "Gaming perfermance"),
      Criteria(ComputerParameter.contentCreation, 1, "Content Creation"),
      Criteria(ComputerParameter.multitasking, 1, "Multitasking"),
      Criteria(ComputerParameter.storage, 1, "Storage"),
      Criteria(ComputerParameter.consumption, 1, "Consumption"),
    ];
  }

  setCriteriaValue(ComputerParameter criteria, int value) {
    criterias.firstWhere((e) => e.criteria == criteria).value = value;
    notifyListeners();
  }

  submit() {
    autobuildProvider.setWorstParameters(BestWorstValues(
        worstCriteria,
        criteriaValue(ComputerParameter.price),
        criteriaValue(ComputerParameter.gaming),
        criteriaValue(ComputerParameter.multitasking),
        criteriaValue(ComputerParameter.consumption),
        criteriaValue(ComputerParameter.contentCreation),
        criteriaValue(ComputerParameter.storage)));
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
