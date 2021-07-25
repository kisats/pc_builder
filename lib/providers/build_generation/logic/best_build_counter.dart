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
  return counter.countBestBuilds();
}

class BestBuildCounter {
  String name;

  List<Cpu> cpus;
  List<Motherboard> mbList;
  List<RAM> ramList;
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
    for (var cpu in cpus) {
      _addMoterboards(cpu);
    }
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

    if (psu != null) countByAlgoritm(cpu, mb, gpu, psu);
  }

  countByAlgoritm(Cpu cpu, Motherboard mb, VideoCard gpu, PowerSupply psu) {
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
      logic.countByTopsis(
          builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
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

class BestBuildCounterTOPSIS extends BestBuildCounter {

  BestBuildCounterTOPSIS(
      List<Cpu> cpus,
      List<Motherboard> mbList,
      List<RAM> ramList,
      List<VideoCard> gpuList,
      List<SSD> ssdList,
      List<Case> caseList,
      List<PowerSupply> psuList,
      List<Cooler> coolerList,
      double maxBuildPrice,
      String name,
      BuildWeights weights)
      : super(cpus, mbList, ramList, gpuList, ssdList, caseList, psuList, coolerList, maxBuildPrice,
            name, weights);

  @override
  countByAlgoritm(Cpu cpu, Motherboard mb, VideoCard gpu, PowerSupply psu) {
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
      logic.countByTopsis(
          builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
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

class BestBuildCounterWSM extends BestBuildCounter {

  BestBuildCounterWSM(
      List<Cpu> cpus,
      List<Motherboard> mbList,
      List<RAM> ramList,
      List<VideoCard> gpuList,
      List<SSD> ssdList,
      List<Case> caseList,
      List<PowerSupply> psuList,
      List<Cooler> coolerList,
      double maxBuildPrice,
      String name,
      BuildWeights weights)
      : super(cpus, mbList, ramList, gpuList, ssdList, caseList, psuList, coolerList, maxBuildPrice,
            name, weights);

  @override
  countByAlgoritm(Cpu cpu, Motherboard mb, VideoCard gpu, PowerSupply psu) {
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
      logic.countByWSM(
          builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
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

class BestBuildCounterVIKOR extends BestBuildCounter {

  BestBuildCounterVIKOR(
      List<Cpu> cpus,
      List<Motherboard> mbList,
      List<RAM> ramList,
      List<VideoCard> gpuList,
      List<SSD> ssdList,
      List<Case> caseList,
      List<PowerSupply> psuList,
      List<Cooler> coolerList,
      double maxBuildPrice,
      String name,
      BuildWeights weights)
      : super(cpus, mbList, ramList, gpuList, ssdList, caseList, psuList, coolerList, maxBuildPrice,
            name, weights);

  @override
  countByAlgoritm(Cpu cpu, Motherboard mb, VideoCard gpu, PowerSupply psu) {
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
      logic.countByVIKOR(
          builds.map((e) => e.toCountingRow()).toList(), Build.getCountingColumns(weights));
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
