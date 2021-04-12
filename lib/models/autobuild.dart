import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/models/video_card.dart';

class Criteria {
  ComputerParameter criteria;
  int value;
  String name;

  Criteria(this.criteria, this.value, this.name);
}

enum ComputerParameter { gaming, contentCreation, storage, multitasking, consumption, price, none }

class Build {
  final Cpu cpu;
  final Motherboard mb;
  final VideoCard gpu;
  final RAM ram;
  final SSD ssd;
  final PowerSupply psu;
  Cooler cooler;
  Case computerCase;
  String name;

  double perfermanceScore;

  double get price =>
      (cpu?.price ?? 0) +
      (mb?.price ?? 0) +
      (gpu?.price ?? 0) +
      (ssd?.price ?? 0) +
      (ram?.price ?? 0) +
      (psu?.price ?? 0) +
      (cooler?.price ?? 0) +
      (computerCase?.price ?? 0);

  Build(
      {this.cpu,
      this.mb,
      this.gpu,
      this.ram,
      this.ssd,
      this.psu,
      this.cooler,
      this.computerCase,
      this.perfermanceScore,
      this.name});
}

class BestWorstValues {
  ComputerParameter mainParam;

  int price;
  int gaming;
  int multitasking;
  int storage;
  int consumption;
  int contentCreation;

  BestWorstValues(this.mainParam, this.price, this.gaming, this.multitasking, this.consumption,
      this.contentCreation, this.storage);
}

class CountingRow {
  dynamic component;
  List<Cell> cells;

  double distanceWorst;
  double distanceBest;

  CountingRow(this.component, this.cells);
}

class Cell {
  int columnId;
  double value;
  double normalizedValue;
  double weightedValue;

  Cell(this.columnId, this.value);
}

class CountingColumn {
  int id;
  String name;
  double weight;
  bool greaterIsBetter;

  double denominater;

  double idealBest;
  double idealWorst;

  CountingColumn(this.id, this.name, this.weight, this.greaterIsBetter);
}

class BuildWeights {
  double price;
  double gaming;
  double consumption;
  double contentCreation;
  double storage;
  double multitasking;

  double constant;

  BuildWeights(this.price, this.gaming, this.consumption, this.contentCreation, this.storage,
      this.multitasking, this.constant);
}
