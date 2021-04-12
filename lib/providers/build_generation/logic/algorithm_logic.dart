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

  countBySimple(List<CountingRow> data, List<CountingColumn> columns) {
    for (var column in columns) {
      if (column.greaterIsBetter)
        column.denominater =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).max();
      else
        column.denominater =
            data.select((e, _) => e.cells.firstWhere((e) => e.columnId == column.id).value).min();
    }

    for (var row in data) {
      row.component.perfermanceScore = _countVector(row, columns);
    }
  }

  double _countVector(CountingRow row, List<CountingColumn> columns) {
    for (var cell in row.cells) {
      var column = columns.firstWhere((e) => e.id == cell.columnId);
      if (column.greaterIsBetter)
        cell.weightedValue = cell.value / column.denominater * column.weight;
      else
        cell.weightedValue = column.denominater / cell.value * column.weight;
    }

    return row.cells.sum((e) => e.weightedValue);
  }
}


