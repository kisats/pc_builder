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
  double weight;

  Criteria(this.criteria, this.value, this.name);
}

enum ComputerParameter { gaming, contentCreation, storage, multitasking, consumption, price, none }

mapComputerParameter(ComputerParameter param) {
  switch (param) {
    case ComputerParameter.none:
      return "--";
    case ComputerParameter.price:
      return "Price";
    case ComputerParameter.consumption:
      return "Consumption";
    case ComputerParameter.contentCreation:
      return "Content Creation";
    case ComputerParameter.multitasking:
      return "Multitasking";
    case ComputerParameter.gaming:
      return "Gaming";
    case ComputerParameter.storage:
      return "Storage";
    default:
      return "--";
  }
}

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

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, cpu.cores.toDouble()),
      Cell(2, cpu.speed),
      Cell(3, cpu.boost ?? cpu.speed),
      Cell(4, gpu.boost?.toDouble() ?? gpu.clock?.toDouble() ?? 0),
      Cell(5, gpu.clock.toDouble()),
      Cell(6, gpu.memory.toDouble()),
      Cell(7, ram.voltage),
      Cell(8, (ram.stickMemory * ram.stickCount).toDouble()),
      Cell(9, ram.casLatency),
      Cell(10, ram.fwLatency),
      Cell(11, ssd.capacity),
      Cell(12, ssd.cache.toDouble()),
      Cell(13, ssd.isNVME ? 1.0 : 0.3),
      Cell(14, psu.wattage.toDouble()),
      Cell(
          15,
          cpu.price +
              gpu.price +
              ram.price +
              psu.price +
              ssd.price +
              (cooler?.price ?? 0) +
              (computerCase?.price ?? 0) +
              mb.price),
      Cell(16, cpu.consumption?.toDouble() ?? 180 + gpu.consumption?.toDouble() ?? 300),
      Cell(17, ram.ddrValue),
      Cell(18, gpu.ddrValue),
      Cell(19, gpu.coolingValue),
      Cell(20, psu.efficiencyValue),
      Cell(21, ram.speed.toDouble()),
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    return [
      CountingColumn(
          1, "CpuCores", weights.contentCreation * 0.3 + weights.multitasking * 0.1, true),
      CountingColumn(2, "CpuSpeed", weights.contentCreation * 0.3, true),
      CountingColumn(3, "CpuBoost", weights.contentCreation * 0.3, true),
      CountingColumn(4, "GpuBoost", weights.gaming * 0.2, true),
      CountingColumn(5, "GpuClock", weights.gaming * 0.2, true),
      CountingColumn(6, "GpuMemory", weights.gaming * 0.2, true),
      CountingColumn(7, "Ram Voltage", weights.multitasking * 0.3, true),
      CountingColumn(
          8, "Ram Memory", weights.multitasking * 0.15 + weights.contentCreation * 0.05, true),
      CountingColumn(9, "Ram CasLatency", weights.multitasking * 0.05, true),
      CountingColumn(10, "Ram FwLatency", weights.multitasking * 0.05, true),
      CountingColumn(11, "SSD Storage", weights.storage * 0.4, true),
      CountingColumn(12, "SSD Cache", weights.storage * 0.3, true),
      CountingColumn(13, "SSD Nvme", weights.storage * 0.3, true),
      CountingColumn(14, "PSU Wattage", weights.consumption * 0.05, true),
      CountingColumn(15, "Price", weights.price, false),
      CountingColumn(16, "Consumption", weights.consumption * 0.65, false),
      CountingColumn(
          17, "Ram DDR", weights.multitasking * 0.2 + weights.contentCreation * 0.05, true),
      CountingColumn(18, "GPU DDR", weights.gaming * 0.2, true),
      CountingColumn(19, "GPU Cooling", weights.gaming * 0.2, false),
      CountingColumn(20, "PSU Efficiency", weights.consumption * 0.3, false),
      CountingColumn(21, "Ram Speed", weights.multitasking * 0.15, false),
    ];
  }
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

  double max;
  double min;

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
