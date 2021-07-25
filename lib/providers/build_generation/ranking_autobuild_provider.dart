import 'package:flutter/cupertino.dart';
import 'package:pc_builder/models/autobuild.dart';

class RankingAutoBuildProvider extends ChangeNotifier {
  ComputerParameter firstParam;
  ComputerParameter secondParam;
  ComputerParameter thirdParam;
  ComputerParameter fourthParam;
  ComputerParameter fiftParam;
  ComputerParameter sixParam;

  bool get canGenerate =>
      firstParam != null &&
      secondParam != null &&
      thirdParam != null &&
      fourthParam != null &&
      fiftParam != null &&
      sixParam != null;

  isParamTaken(ComputerParameter param) =>
      firstParam == param ||
      secondParam == param ||
      thirdParam == param ||
      fourthParam == param ||
      fiftParam == param ||
      sixParam == param;

  setFirst(ComputerParameter param) {
    _clearParams(param);
    firstParam = param;
    notifyListeners();
  }

  setSecond(ComputerParameter param) {
    _clearParams(param);
    secondParam = param;
    notifyListeners();
  }

  setThird(ComputerParameter param) {
    _clearParams(param);
    thirdParam = param;
    notifyListeners();
  }

  setFourth(ComputerParameter param) {
    _clearParams(param);
    fourthParam = param;
    notifyListeners();
  }

  setFift(ComputerParameter param) {
    _clearParams(param);
    fiftParam = param;
    notifyListeners();
  }

  setSix(ComputerParameter param) {
    _clearParams(param);
    sixParam = param;
    notifyListeners();
  }

  _clearParams(ComputerParameter param) {
    if (firstParam == param) firstParam = null;
    if (secondParam == param) secondParam = null;
    if (thirdParam == param) thirdParam = null;
    if (fourthParam == param) fourthParam = null;
    if (fiftParam == param) fiftParam = null;
    if (sixParam == param) sixParam = null;
  }

  countWeights() {
    var params = [
      ParamRank(firstParam, 6),
      ParamRank(secondParam, 5),
      ParamRank(thirdParam, 4),
      ParamRank(fourthParam, 3),
      ParamRank(fiftParam, 2),
      ParamRank(sixParam, 1)];

    var price = params.firstWhere((e) => e.param == ComputerParameter.price).rank / 21;
    var gaming = params.firstWhere((e) => e.param == ComputerParameter.gaming).rank / 21;
    var contentCreation = params.firstWhere((e) => e.param == ComputerParameter.contentCreation).rank / 21;
    var multitasking = params.firstWhere((e) => e.param == ComputerParameter.multitasking).rank / 21;
    var consumption = params.firstWhere((e) => e.param == ComputerParameter.consumption).rank / 21;
    var storage = params.firstWhere((e) => e.param == ComputerParameter.storage).rank / 21;

    return BuildWeights(price, gaming, consumption, contentCreation, storage, multitasking, null);
  }
}

class ParamRank {
  ComputerParameter param;
  int rank;

  ParamRank(this.param, this.rank);
}
