import 'package:cassowary/cassowary.dart';
import 'package:pc_builder/models/autobuild.dart';

class BestWorstMethodLogic {
  BuildWeights countWeights(BestWorstValues best, BestWorstValues worst) {
    var solver = Solver();
    var constraints = <Constraint>[];

    var gaming = Param();
    var contentCreation = Param();
    var storage = Param();
    var multitasking = Param();
    var consumption = Param();
    var price = Param();

    var constant = Param();

    Param bestParam = _getParam(
        best.mainParam, gaming, contentCreation, storage, multitasking, consumption, price);

    Param worstParam = _getParam(
        worst.mainParam, gaming, contentCreation, storage, multitasking, consumption, price);

    constraints.add(
        (gaming + contentCreation + storage + multitasking + consumption + price).equals(cm(1)));

    constraints.addAll([
      gaming >= cm(0),
      contentCreation >= cm(0),
      storage >= cm(0),
      multitasking >= cm(0),
      consumption >= cm(0),
      price >= cm(0)
    ]);

    constraints.add(constant <= cm(0.25));

    constraints.add(_getCriteriaWorstOpos(worstParam, gaming, constant, worst.gaming));
    constraints
        .add(_getCriteriaWorstOpos(worstParam, contentCreation, constant, worst.contentCreation));
    constraints.add(_getCriteriaWorstOpos(worstParam, storage, constant, worst.storage));
    constraints.add(_getCriteriaWorstOpos(worstParam, multitasking, constant, worst.multitasking));
    constraints.add(_getCriteriaWorstOpos(worstParam, consumption, constant, worst.consumption));
    constraints.add(_getCriteriaWorstOpos(worstParam, price, constant, worst.price));

    constraints.add(_getCriteriaWorst(worstParam, gaming, constant, worst.gaming));
    constraints
        .add(_getCriteriaWorst(worstParam, contentCreation, constant, worst.contentCreation));
    constraints.add(_getCriteriaWorst(worstParam, storage, constant, worst.storage));
    constraints.add(_getCriteriaWorst(worstParam, multitasking, constant, worst.multitasking));
    constraints.add(_getCriteriaWorst(worstParam, consumption, constant, worst.consumption));
    constraints.add(_getCriteriaWorst(worstParam, price, constant, worst.price));

    constraints.add(_getCriteriaBest(bestParam, gaming, constant, best.gaming));
    constraints.add(_getCriteriaBest(bestParam, contentCreation, constant, best.contentCreation));
    constraints.add(_getCriteriaBest(bestParam, storage, constant, best.storage));
    constraints.add(_getCriteriaBest(bestParam, multitasking, constant, best.multitasking));
    constraints.add(_getCriteriaBest(bestParam, consumption, constant, best.consumption));
    constraints.add(_getCriteriaBest(bestParam, price, constant, best.price));

    constraints.add(_getCriteriaBestOpos(bestParam, gaming, constant, best.gaming));
    constraints
        .add(_getCriteriaBestOpos(bestParam, contentCreation, constant, best.contentCreation));
    constraints.add(_getCriteriaBestOpos(bestParam, storage, constant, best.storage));
    constraints.add(_getCriteriaBestOpos(bestParam, multitasking, constant, best.multitasking));
    constraints.add(_getCriteriaBestOpos(bestParam, consumption, constant, best.consumption));
    constraints.add(_getCriteriaBestOpos(bestParam, price, constant, best.price));

    solver
      ..addConstraints(constraints)
      ..flushUpdates();

    return BuildWeights(price.value, gaming.value, consumption.value, contentCreation.value,
        storage.value, multitasking.value, constant.value);
  }

  _getParam(ComputerParameter parameterType, Param gaming, Param contentCreation, Param storage,
      Param multitasking, Param consumption, Param price) {
    switch (parameterType) {
      case ComputerParameter.gaming:
        return gaming;
      case ComputerParameter.contentCreation:
        return contentCreation;
      case ComputerParameter.storage:
        return storage;
      case ComputerParameter.multitasking:
        return multitasking;
      case ComputerParameter.consumption:
        return consumption;
      case ComputerParameter.price:
        return price;
      default:
        return price;
    }
  }

  _getCriteriaBest(Param best, Param param, Param constant, int coef) =>
      (best - cm(coef.toDouble()) * param <= constant)..priority = Priority.required;
  _getCriteriaBestOpos(Param best, Param param, Param constant, int coef) =>
      (cm(coef.toDouble()) * param - best <= constant)..priority = Priority.required;

  _getCriteriaWorst(Param worst, Param param, Param constant, int coef) =>
      (param - cm(coef.toDouble()) * worst <= constant)..priority = Priority.required;
  _getCriteriaWorstOpos(Param worst, Param param, Param constant, int coef) =>
      (cm(coef.toDouble()) * worst - param <= constant)..priority = Priority.required;
}
