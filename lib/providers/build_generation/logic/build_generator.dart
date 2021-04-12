import 'package:flutter/foundation.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/models/video_card.dart';
import 'package:pc_builder/providers/build_generation/logic/algorithm_logic.dart';
import 'package:darq/darq.dart';
import 'package:pc_builder/providers/build_generation/logic/best_build_counter.dart';

class BuildGenerator {
  List<Cpu> cpuList;
  List<Motherboard> mbList;
  List<RAM> ramList;
  List<VideoCard> gpuList;
  List<SSD> ssdList;
  List<Case> caseList;
  List<PowerSupply> psuList;
  List<Cooler> coolerList;

  double maxBuildPrice;

  BuildWeights weights;

  AlgorithmLogic _algorithmLogic;
  FireStore _db;

  List<Build> _builds;

  BuildGenerator() {
    _db = FireStore();
    _algorithmLogic = AlgorithmLogic();
  }

  orderAllParts() async {
    await _db.loadComponents();
    _algorithmLogic.countByTopsis(
        _db.cpuList
            .map((e) => CountingRow(e, [
                  Cell(1, e.cores?.toDouble() ?? 0),
                  Cell(2, e.speed),
                  Cell(3, e.boost ?? e.speed),
                  Cell(4, e.price),
                  Cell(5, e.consumption?.toDouble() ?? 180)
                ]))
            .toList(),
        [
          CountingColumn(1, "Cores", weights.multitasking + weights.storage / 5, true),
          CountingColumn(2, "Speed",
              weights.contentCreation / 1.5 + weights.gaming / 3 + weights.storage / 5, true),
          CountingColumn(3, "Boost",
              weights.contentCreation / 1.5 + weights.gaming / 3 + weights.storage / 5, true),
          CountingColumn(4, "Price", weights.price + weights.storage / 5, false),
          CountingColumn(5, "Consumption", weights.consumption + weights.storage / 5, false)
        ]);
    _algorithmLogic.countByTopsis(
        _db.motherboardList
            .map((e) => CountingRow(e, [
                  Cell(1, e.price),
                  Cell(2, e.maxRam?.toDouble() ?? 0),
                ]))
            .toList(),
        [
          CountingColumn(1, "Price",
              weights.price + weights.consumption + weights.storage + weights.gaming, false),
          CountingColumn(2, "Ram", weights.multitasking + weights.contentCreation, true),
        ]);

    var videoCardValue = weights.gaming * 1.5 + weights.contentCreation / 2;
    var values = weights.storage + weights.multitasking;
    _algorithmLogic.countByTopsis(
        _db.videoCardList
            .map((e) => CountingRow(e, [
                  Cell(1, e.boost?.toDouble() ?? e.clock?.toDouble() ?? 0),
                  Cell(2, e.clock?.toDouble() ?? 0),
                  Cell(3, e.memory?.toDouble() ?? 0),
                  Cell(4, e.price),
                  Cell(5, e.consumption?.toDouble() ?? 300),
                  Cell(6, e.ddrValue),
                  Cell(7, e.coolingValue),
                ]))
            .toList(),
        [
          CountingColumn(1, "Boost", videoCardValue * 0.2 + values * 0.15, true),
          CountingColumn(2, "Clock", videoCardValue * 0.2 + values * 0.15, true),
          CountingColumn(3, "Memory", videoCardValue * 0.3 + values * 0.2, true),
          CountingColumn(4, "Price", weights.price + values * 0.15, false),
          CountingColumn(5, "Consumption", weights.consumption + values * 0.1, false),
          CountingColumn(6, "DDr", videoCardValue * 0.25 + values * 0.2, false),
          CountingColumn(7, "Cooling", videoCardValue * 0.05 + values * 0.05, false),
        ]);
    var ramValue = weights.multitasking * 2 +
        weights.contentCreation / 1.33 +
        weights.gaming / 1.66 +
        weights.storage / 2 +
        weights.consumption / 2;
    _algorithmLogic.countByTopsis(
        _db.ramList
            .map((e) => CountingRow(e, [
                  Cell(1, e.voltage),
                  Cell(2, (e.stickMemory * e.stickCount).toDouble()),
                  Cell(3, e.price),
                  Cell(4, e.casLatency),
                  Cell(5, e.fwLatency),
                  Cell(6, e.ddrValue),
                  Cell(7, e.speed.toDouble())
                ]))
            .toList(),
        [
          CountingColumn(1, "Voltage", ramValue * 0.1, true),
          CountingColumn(2, "Memory", ramValue * 0.20, true),
          CountingColumn(
              3, "Price", weights.price + weights.storage / 2 + weights.consumption / 2, false),
          CountingColumn(4, "CasLatency", ramValue * 0.1, true),
          CountingColumn(5, "FwLatency", ramValue * 0.1, true),
          CountingColumn(6, "DDR", ramValue * 0.28, true),
          CountingColumn(7, "Speed", ramValue * 0.22, true),
        ]);
    var ssdValue = weights.storage * 2 +
        weights.multitasking / 1.33 +
        weights.contentCreation / 1.66 +
        weights.gaming / 4 +
        weights.consumption / 4;
    _algorithmLogic.countByTopsis(
        _db.ssdList
            .map((e) => CountingRow(e, [
                  Cell(1, e.capacity),
                  Cell(2, e.cache?.toDouble() ?? 0),
                  Cell(3, e.price),
                  Cell(4, e.isNVME ? 1.5 : 0.3),
                ]))
            .toList(),
        [
          CountingColumn(1, "Storage", ssdValue * 0.4, true),
          CountingColumn(2, "Cache", ssdValue * 0.3, true),
          CountingColumn(
              3, "Price", weights.price + weights.storage / 2 + weights.consumption / 2, false),
          CountingColumn(4, "Nvme", ssdValue * 0.3, true),
        ]);

    var psu = weights.storage + weights.gaming + weights.multitasking + weights.contentCreation;
    _algorithmLogic.countByTopsis(
        _db.powerSupplyList
            .map((e) => CountingRow(e, [
                  Cell(1, e.wattage.toDouble()),
                  Cell(2, e.price),
                  Cell(3, e.efficiencyValue),
                ]))
            .toList(),
        [
          CountingColumn(1, "Wattage", weights.consumption * 0.4 + psu / 3, true),
          CountingColumn(2, "Price", weights.price + psu / 3, false),
          CountingColumn(3, "Efficiency", weights.consumption * 0.6 + psu / 3, true),
        ]);
    _algorithmLogic.countByTopsis(
        _db.caseList
            .map((e) => CountingRow(e, [
                  Cell(1, e.externalBays?.toDouble() ?? 0),
                  Cell(2, e.price),
                  Cell(3, e.sidePanel == null || e.sidePanel == "None" ? 1 : 2),
                ]))
            .toList(),
        [
          CountingColumn(1, "Bays", 0.2, true),
          CountingColumn(2, "Price", 0.6, false),
          CountingColumn(3, "Side panel", 0.2, true),
        ]);
    var collerPriceImpact =
        weights.price + weights.consumption + weights.gaming + weights.storage * 0.6;
    var collerMultitaskImpact =
        weights.contentCreation + weights.multitasking + weights.storage * 0.4;
    _algorithmLogic.countByTopsis(
        _db.coolerList
            .map((e) => CountingRow(e, [
                  Cell(1, e.minRPM?.toDouble() ?? 0),
                  Cell(2, e.maxRPM?.toDouble() ?? 0),
                  Cell(3, e.minNoise?.toDouble() ?? 0),
                  Cell(4, e.maxNoise?.toDouble() ?? 0),
                  Cell(5, e.price),
                ]))
            .toList(),
        [
          CountingColumn(1, "MinRPM", collerMultitaskImpact * 0.45, false),
          CountingColumn(2, "MaxRPM", collerMultitaskImpact * 0.45, true),
          CountingColumn(3, "MinNoise", collerMultitaskImpact * 0.05, false),
          CountingColumn(4, "MaxNoise", collerPriceImpact * 0.05, false),
          CountingColumn(5, "Price", collerPriceImpact * 0.95, false),
        ]);

    cpuList = _db.cpuList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 2)
        .take(36)
        .toList();
    mbList = _db.motherboardList
        .orderBy((x) => x.perfermanceScore)
        .where((e) => e.price < maxBuildPrice / 4)
        .reverse()
        .toList();
    ramList = _db.ramList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .take(50)
        .toList();
    gpuList = _db.videoCardList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 2)
        .take(50)
        .toList();
    ssdList = _db.ssdList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .take(50)
        .toList();
    caseList = _db.caseList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .toList();
    psuList = _db.powerSupplyList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .toList();
    coolerList = _db.coolerList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .toList();
  }

  List<BestBuildCounter> getBuildCounters() {
    return [
      BestBuildCounter(
          cpuList.getRange(0, (cpuList.length * 1 / 4).ceil()).toList(),
          mbList,
          ramList,
          gpuList,
          ssdList,
          caseList,
          psuList,
          coolerList,
          maxBuildPrice,
          "COUNTER 1",
          weights),
      BestBuildCounter(
          cpuList
              .getRange((cpuList.length * 1 / 4).ceil(), (cpuList.length * 2 / 4).ceil())
              .toList(),
          mbList,
          ramList,
          gpuList,
          ssdList,
          caseList,
          psuList,
          coolerList,
          maxBuildPrice,
          "COUNTER 2",
          weights),
      BestBuildCounter(
          cpuList
              .getRange((cpuList.length * 2 / 4).ceil(), (cpuList.length * 3 / 4).ceil())
              .toList(),
          mbList,
          ramList,
          gpuList,
          ssdList,
          caseList,
          psuList,
          coolerList,
          maxBuildPrice,
          "Counter 3",
          weights),
      BestBuildCounter(
          cpuList.getRange((cpuList.length * 3 / 4).ceil(), cpuList.length).toList(),
          mbList,
          ramList,
          gpuList,
          ssdList,
          caseList,
          psuList,
          coolerList,
          maxBuildPrice,
          "COUNTER 4",
          weights)
    ];
  }

  Future<int> generateBuilds() async {
    var counters = <Future>[];
    _builds = [];

    var counter1 = BestBuildCounter(
        cpuList.getRange(0, (cpuList.length * 1 / 4).ceil()).toList(),
        mbList,
        ramList,
        gpuList,
        ssdList,
        caseList,
        psuList,
        coolerList,
        maxBuildPrice,
        "COUNTER 1",
        weights);
    var counter2 = BestBuildCounter(
        cpuList.getRange((cpuList.length * 1 / 4).ceil(), (cpuList.length * 2 / 4).ceil()).toList(),
        mbList,
        ramList,
        gpuList,
        ssdList,
        caseList,
        psuList,
        coolerList,
        maxBuildPrice,
        "COUNTER 2",
        weights);
    var counter3 = BestBuildCounter(
        cpuList.getRange((cpuList.length * 2 / 4).ceil(), (cpuList.length * 3 / 4).ceil()).toList(),
        mbList,
        ramList,
        gpuList,
        ssdList,
        caseList,
        psuList,
        coolerList,
        maxBuildPrice,
        "Counter 3",
        weights);
    var counter4 = BestBuildCounter(
        cpuList.getRange((cpuList.length * 3 / 4).ceil(), cpuList.length).toList(),
        mbList,
        ramList,
        gpuList,
        ssdList,
        caseList,
        psuList,
        coolerList,
        maxBuildPrice,
        "COUNTER 4",
        weights);
    counters.add(compute(computeBestBuilds, counter1, debugLabel: null));
    counters.add(compute(computeBestBuilds, counter2, debugLabel: null));

    /* _builds += await compute(computeBestBuilds, counter1);
    _builds += await compute(computeBestBuilds, counter2);
    _builds += await compute(computeBestBuilds, counter3);
    _builds += await compute(computeBestBuilds, counter4); */

    /* counters = []; */

    counters.add(compute(computeBestBuilds, counter3, debugLabel: null));
    counters.add(compute(computeBestBuilds, counter4, debugLabel: null));

    var res = await Future.wait(counters);

    for (var builds in res) {
      _builds += builds;
    }

    return this._builds.length;
  }

  List<Build> findBestBuildsByTopsis(List<Build> builds) {
    builds ??= _builds;
    _algorithmLogic.countByTopsis(
        builds
            .map((e) => CountingRow(e, [
                  Cell(1, e.cpu.cores.toDouble()),
                  Cell(2, e.cpu.speed),
                  Cell(3, e.cpu.boost ?? e.cpu.speed),
                  Cell(4, e.gpu.boost?.toDouble() ?? e.gpu.clock?.toDouble() ?? 0),
                  Cell(5, e.gpu.clock.toDouble()),
                  Cell(6, e.gpu.memory.toDouble()),
                  Cell(7, e.ram.voltage),
                  Cell(8, (e.ram.stickMemory * e.ram.stickCount).toDouble()),
                  Cell(9, e.ram.casLatency),
                  Cell(10, e.ram.fwLatency),
                  Cell(11, e.ssd.capacity),
                  Cell(12, e.ssd.cache.toDouble()),
                  Cell(13, e.ssd.isNVME ? 1.0 : 0.3),
                  Cell(14, e.psu.wattage.toDouble()),
                  Cell(
                      15,
                      e.cpu.price +
                          e.gpu.price +
                          e.ram.price +
                          e.psu.price +
                          e.ssd.price +
                          e.cooler.price +
                          e.computerCase.price +
                          e.mb.price),
                  Cell(16,
                      e.cpu.consumption?.toDouble() ?? 180 + e.gpu.consumption?.toDouble() ?? 300),
                  Cell(17, e.ram.ddrValue),
                  Cell(18, e.gpu.ddrValue),
                  Cell(19, e.gpu.coolingValue),
                  Cell(20, e.psu.efficiencyValue),
                  Cell(21, e.ram.speed.toDouble()),
                ]))
            .toList(),
        [
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
          CountingColumn(14, "PSU Wattage", weights.consumption * 0.16, true),
          CountingColumn(15, "Price", weights.price, false),
          CountingColumn(16, "Consumption", weights.consumption * 0.65, false),
          CountingColumn(
              17, "Ram DDR", weights.multitasking * 0.2 + weights.contentCreation * 0.05, true),
          CountingColumn(18, "GPU DDR", weights.gaming * 0.2, true),
          CountingColumn(19, "GPU Cooling", weights.gaming * 0.2, false),
          CountingColumn(20, "PSU Efficiency", weights.consumption * 0.19, false),
          CountingColumn(21, "Ram Speed", weights.multitasking * 0.15, false),
        ]);
    builds = builds.orderBy((e) => e.perfermanceScore).reverse().toList();
    var bestBuilds = <Build>[];
    bestBuilds.add(builds.first);
    builds.remove(bestBuilds.first);
    bestBuilds.add(builds.firstWhere((e) => e.cpu != bestBuilds.first.cpu));
    builds.remove(bestBuilds[1]);
    bestBuilds.add(builds.firstWhere((e) => e.gpu != bestBuilds.first.gpu));
    builds.remove(bestBuilds[2]);
    bestBuilds
        .add(builds.firstWhere((e) => bestBuilds.first.cpu.isAMD ? e.cpu.isIntel : e.cpu.isAMD));
    builds.remove(bestBuilds[3]);
    bestBuilds += builds.take(4).toList();
    print("SHIT COUNTED");
    print(bestBuilds.length);

    return bestBuilds.toList();
  }
}
