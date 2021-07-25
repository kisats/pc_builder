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

  orderPartsByTopsis() async {
    await _orderAllParts(_algorithmLogic.countByTopsis);
  }

  orderPartsByWSM() async {
    await _orderAllParts(_algorithmLogic.countByWSM);
  }

  orderPartsByVIKOR() async {
    await _orderAllParts(_algorithmLogic.countByVIKOR);
  }

  _orderAllParts(Function(List<CountingRow> a, List<CountingColumn> b) countBy) async {
    await _db.loadComponents();
    countBy(_db.cpuList.map((e) => e.toCountingRow()).toList(), Cpu.getCountingColumns(weights));

    countBy(_db.motherboardList.map((e) => e.toCountingRow()).toList(),
        Motherboard.getCountingColumns(weights));

    countBy(_db.videoCardList.map((e) => e.toCountingRow()).toList(),
        VideoCard.getCountingColumns(weights));

    countBy(_db.ramList.map((e) => e.toCountingRow()).toList(), RAM.getCountingColumns(weights));

    countBy(_db.ssdList.map((e) => e.toCountingRow()).toList(), SSD.getCountingColumns(weights));

    countBy(_db.powerSupplyList.map((e) => e.toCountingRow()).toList(),
        PowerSupply.getCountingColumns(weights));

    countBy(_db.caseList.map((e) => e.toCountingRow()).toList(), Case.getCountingColumns(weights));

    countBy(
        _db.coolerList.map((e) => e.toCountingRow()).toList(), Cooler.getCountingColumns(weights));

    cpuList = _db.cpuList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .take(36)
        .toList();
    mbList = _db.motherboardList
        .orderBy((x) => x.perfermanceScore)
        .where((e) => e.price < maxBuildPrice / 6)
        .reverse()
        .toList();
    ramList = _db.ramList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 6)
        .take(50)
        .toList();
    gpuList = _db.videoCardList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 4)
        .take(50)
        .toList();
    ssdList = _db.ssdList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 6)
        .take(50)
        .toList();
    caseList = _db.caseList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 7)
        .toList();
    psuList = _db.powerSupplyList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 7)
        .toList();
    coolerList = _db.coolerList
        .orderBy((x) => x.perfermanceScore)
        .reverse()
        .where((e) => e.price < maxBuildPrice / 8)
        .toList();
  }

  List<BestBuildCounter> getBuildCountersTOPSIS() {
    return [
      BestBuildCounterTOPSIS(
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
      BestBuildCounterTOPSIS(
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
      BestBuildCounterTOPSIS(
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
      BestBuildCounterTOPSIS(
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

  List<BestBuildCounter> getBuildCountersWSM() {
    return [
      BestBuildCounterWSM(
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
      BestBuildCounterWSM(
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
      BestBuildCounterWSM(
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
      BestBuildCounterWSM(
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

  List<BestBuildCounter> getBuildCountersVIKOR() {
    return [
      BestBuildCounterVIKOR(
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
      BestBuildCounterVIKOR(
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
      BestBuildCounterVIKOR(
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
      BestBuildCounterVIKOR(
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

  List<Build> findBestBuildsByTopsis(List<Build> builds) {
    builds ??= _builds;
    _algorithmLogic.countByTopsis(
        builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
    return _getBestBuilds(builds);
  }

  List<Build> findBestBuildsByWSM(List<Build> builds) {
    builds ??= _builds;
    _algorithmLogic.countByWSM(
        builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
    return _getBestBuilds(builds);
  }

  List<Build> findBestBuildsByVIKOR(List<Build> builds) {
    builds ??= _builds;
    _algorithmLogic.countByVIKOR(
        builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
    return _getBestBuilds(builds);
  }

  List<Build> _getBestBuilds(List<Build> builds) {
    builds = builds.orderBy((e) => e.perfermanceScore).reverse().toList();
    var bestBuilds = <Build>[];
    bestBuilds.add(builds.first);
    builds.remove(bestBuilds.first);
    bestBuilds.add(builds.firstWhere((e) => e.cpu != bestBuilds.first.cpu));
    builds.remove(bestBuilds[1]);
    bestBuilds.add(builds.firstWhere((e) => e.gpu != bestBuilds.first.gpu));
    builds.remove(bestBuilds[2]);
    var build = builds.firstWhere((e) => bestBuilds.first.cpu.isAMD ? e.cpu.isIntel : e.cpu.isAMD,
        orElse: () => null);
    if (build != null){
      bestBuilds.add(build);
      builds.remove(bestBuilds[3]);
    } 
    bestBuilds += builds.take(build != null ? 4 : 3).toList();

    return bestBuilds.toList();
  }
}
