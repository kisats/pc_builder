import 'dart:math';

import 'package:darq/darq.dart';
import 'package:pc_builder/models/autobuild.dart';

class AlgorithmLogic {
  countByTopsis(List<CountingRow> data, List<CountingColumn> columns) {
    for (var column in columns) {
      column.denominater = sqrt(data
          .select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value)
          .sum((e) => e * e));
    }

    for (var row in data) {
      row.cells = _countWeightedValueInCells(row.cells, columns);
    }

    for (var column in columns) {
      var columnValues =
          data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).weightedValue);
      if (column.greaterIsBetter) {
        column.idealBest = columnValues.max();
        column.idealWorst = columnValues.min();
      } else {
        column.idealBest = columnValues.min();
        column.idealWorst = columnValues.max();
      }
    }

    for (var row in data) {
      row.component.perfermanceScore = _getPerfermanceScore(row.cells, columns);
    }
  }

  List<Cell> _countWeightedValueInCells(List<Cell> cells, List<CountingColumn> columns) {
    for (var cell in cells) {
      var column = columns.firstWhere((e) => e.id == cell.columnId);
      cell.weightedValue = cell.value / column.denominater * column.weight;
    }
    return cells;
  }

  double _getPerfermanceScore(List<Cell> cells, List<CountingColumn> columns) {
    var distanceBest = sqrt(cells
        .select((e, _) =>
            (e.weightedValue - columns.firstWhere((c) => c.id == e.columnId).idealBest) *
            (e.weightedValue - columns.firstWhere((c) => c.id == e.columnId).idealBest))
        .sum());
    var distanceWorst = sqrt(cells
        .select((e, _) =>
            (e.weightedValue - columns.firstWhere((c) => c.id == e.columnId).idealWorst) *
            (e.weightedValue - columns.firstWhere((c) => c.id == e.columnId).idealWorst))
        .sum());
    return distanceWorst / (distanceBest + distanceWorst);
  }

  countByWSM(List<CountingRow> data, List<CountingColumn> columns) {
    for (var column in columns) {
      if (column.greaterIsBetter)
        column.denominater =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).max();
      else
        column.denominater =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).min();
    }

    for (var row in data) {
      row.component.perfermanceScore = _countPerfermanceScore(row, columns);
    }
  }

  double _countPerfermanceScore(CountingRow row, List<CountingColumn> columns) {
    for (var cell in row.cells) {
      var column = columns.firstWhere((e) => e.id == cell.columnId);
      if (column.greaterIsBetter)
        cell.weightedValue =
            cell.value == 0 ? 0.01 : cell.value / column.denominater * column.weight;
      else
        cell.weightedValue =
            column.denominater / cell.value == 0 ? 0.01 : cell.value * column.weight;
    }

    return row.cells.sum((e) => e.weightedValue);
  }

  countByVIKOR(List<CountingRow> data, List<CountingColumn> columns) {
    for (var column in columns) {
      if (column.greaterIsBetter) {
        column.idealBest =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).max();
        column.idealWorst =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).min();
      } else {
        column.idealBest =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).min();
        column.idealWorst =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).max();
      }
    }

    for (var row in data) {
      _countUnityMeasure(row, columns);
    }

    var sStar = data.select((r, _) => r.distanceBest).min();
    var sMinus = data.select((r, _) => r.distanceBest).max();

    var rStar = data.select((r, _) => r.distanceWorst).min();
    var rMinus = data.select((r, _) => r.distanceWorst).max();

    for (var row in data) {
      row.component.perfermanceScore = -1 * _calculateQi(row, sStar, sMinus, rStar, rMinus);
    }
  }

  _countUnityMeasure(CountingRow row, List<CountingColumn> columns) {
    for (var cell in row.cells) {
      var column = columns.firstWhere((e) => e.id == cell.columnId);
      if (column.idealBest - cell.value == 0)
        cell.weightedValue = 0;
      else
        cell.weightedValue = column.weight *
            ((column.idealBest - cell.value) / (column.idealBest - column.idealWorst));
    }

    row.distanceBest = row.cells.sum((c) => c.weightedValue);
    row.distanceWorst = row.cells.select((c, _) => c.weightedValue).max();
  }

  _calculateQi(CountingRow row, double sStar, double sMinus, double rStar, double rMinus) {
    var v = 0.5;
    return v * (row.distanceBest - sStar) / (sMinus - sStar) +
        (1 - v) * (row.distanceWorst - rStar) / (rMinus - rStar);
  }
}
