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

List<Build> computeBestBuilds(BestBuildCounter counter) {
  print("stariting counter" + counter.name);
  return counter.countBestBuilds();
}

class BestBuildCounter {
  final String name;

  final List<Cpu> cpus;
  final List<Motherboard> mbList;
  final List<RAM> ramList;
  final List<VideoCard> gpuList;
  final List<SSD> ssdList;
  final List<Case> caseList;
  final List<PowerSupply> psuList;
  final List<Cooler> coolerList;

  final double maxBuildPrice;

  final BuildWeights weights;

  List<Build> bestBuilds = [];
  AlgorithmLogic logic = AlgorithmLogic();

  BestBuildCounter(this.cpus, this.mbList, this.ramList, this.gpuList, this.ssdList, this.caseList,
      this.psuList, this.coolerList, this.maxBuildPrice, this.name, this.weights);

  List<Build> countBestBuilds() {
    print("$name" + cpus.length.toString());
    for (var cpu in cpus) {
      _addMoterboards(cpu);
    }
    print("BUILDS COUNTED : $name}  -- ${bestBuilds.length}");
    return bestBuilds;
  }

  _addMoterboards(Cpu cpu) {
    var mb = mbList.firstWhere((e) => e.socket == cpu.socket, orElse: () => null);
    if (mb != null) _addGPU(cpu, mb);
  }

  _addGPU(Cpu cpu, Motherboard mb) {
    for (var gpu in gpuList) {
      _addPSU(cpu, mb, gpu);
    }
  }

  _addPSU(Cpu cpu, Motherboard mb, VideoCard gpu) {
    var psu = psuList.firstWhere(
        (e) =>
            e.wattage * 0.8 > cpu.consumption + gpu.consumption &&
            cpu.price + gpu.price + mb.price + e.price + 300 < maxBuildPrice,
        orElse: () => null);

    if (psu != null) _countBestBuild(cpu, mb, gpu, psu);
  }

  _countBestBuild(Cpu cpu, Motherboard mb, VideoCard gpu, PowerSupply psu) {
    var builds = <Build>[];

    for (var ssd in ssdList) {
      for (var ram in ramList) {
        if (mb.ramSlots >= ram.stickCount &&
            cpu.price + mb.price + gpu.price + psu.price + ssd.price + ram.price + 150 <
                maxBuildPrice)
          builds.add(
              Build(cpu: cpu, mb: mb, gpu: gpu, ram: ram, ssd: ssd, psu: psu, name: "Generated"));
      }
    }

    if (builds.isNotEmpty)
      logic.countBySimple(
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
                            e.mb.price),
                    Cell(
                        16,
                        e.cpu.consumption?.toDouble() ??
                            180 + e.gpu.consumption?.toDouble() ??
                            300),
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
            CountingColumn(4, "GpuBoost", weights.gaming * 0.333, true),
            CountingColumn(5, "GpuClock", weights.gaming * 0.333, true),
            CountingColumn(6, "GpuMemory", weights.gaming * 0.333, true),
            CountingColumn(7, "Ram Voltage", weights.multitasking * 0.3, true),
            CountingColumn(
                8, "Ram Memory", weights.multitasking * 0.15 + weights.contentCreation * 0.05, true),
            CountingColumn(9, "Ram CasLatency", weights.multitasking * 0.05, true),
            CountingColumn(10, "Ram FwLatency", weights.multitasking * 0.05, true),
            CountingColumn(11, "SSD Storage", weights.storage * 0.4, true),
            CountingColumn(12, "SSD Cache", weights.storage * 0.3, true),
            CountingColumn(13, "SSD Nvme", weights.storage * 0.3, true),
            CountingColumn(14, "PSU Wattage", weights.consumption * 0.35, true),
            CountingColumn(15, "Price", weights.price, false),
            CountingColumn(16, "Consumption", weights.consumption * 0.65, false),
            CountingColumn(
                17, "Ram DDR", weights.multitasking * 0.2 + weights.contentCreation * 0.05, true),
            CountingColumn(18, "GPU DDR", weights.gaming * 0.2, true),
            CountingColumn(19, "GPU Cooling", weights.gaming * 0.2, false),
            CountingColumn(20, "PSU Efficiency", weights.consumption * 0.19, false),
            CountingColumn(21, "Ram Speed", weights.multitasking * 0.15, false),
          ]);
    if (builds.isNotEmpty) {
      var best = builds.orderBy((e) => e.perfermanceScore).reverse().take(5).toList();
      for (var build in best) {
        var buildPrice = build.cpu.price +
            build.gpu.price +
            build.mb.price +
            build.psu.price +
            build.ram.price +
            build.ssd.price;
        var cooler = coolerList.firstWhere((e) => e.price + buildPrice + 70 < maxBuildPrice,
            orElse: () => null);
        var cas = caseList.firstWhere((e) => e.price + buildPrice + cooler.price < maxBuildPrice,
            orElse: () => null);
        if (cooler != null && cas != null) {
          build.computerCase = cas;
          build.cooler = cooler;
          bestBuilds.add(build);
        }
      }
    }
  }
}
