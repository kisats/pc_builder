import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';

class BestCriteriaSelectionProvider extends ChangeNotifier {
  BWAutoBuildProvider autobuildProvider;

  List<Criteria> criterias;

  List<ComputerParameter> computerParams;

  ComputerParameter bestCriteria;

  bool get isDisabled => bestCriteria == null || bestCriteria == ComputerParameter.none;

  BestCriteriaSelectionProvider(this.autobuildProvider) {
    _generateCriterias();
    bestCriteria = ComputerParameter.none;
    computerParams = [
      ComputerParameter.none,
      ComputerParameter.gaming,
      ComputerParameter.contentCreation,
      ComputerParameter.multitasking,
      ComputerParameter.price,
      ComputerParameter.storage,
      ComputerParameter.consumption
    ];
  }

  setBestCritera(ComputerParameter criteria) {
    bestCriteria = criteria;
    _generateCriterias();
    criterias.removeWhere((e) => e.criteria == bestCriteria);
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
    autobuildProvider.setBestParameters(BestWorstValues(
        bestCriteria,
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
