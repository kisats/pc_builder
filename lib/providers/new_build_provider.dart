import 'package:flutter/foundation.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/models/video_card.dart';

class NewBuildProvider extends ChangeNotifier {
  Cpu cpu;
  Motherboard motherboard;
  RAM ram;
  VideoCard gpu;
  SSD ssd;
  PowerSupply psu;
  Cooler cooler;
  Case pcCase;

  bool isGenerated;

  double get buildPrice =>
      (cpu?.price ?? 0) +
      (motherboard?.price ?? 0) +
      (ram?.price ?? 0) +
      (gpu?.price ?? 0) +
      (ssd?.price ?? 0) +
      (psu?.price ?? 0) +
      (cooler?.price ?? 0) +
      (pcCase?.price ?? 0);

  int get totalConsumption => (cpu?.consumption ?? 0) + (gpu?.consumption ?? 0);

  bool get isPartsSelected =>
      cpu != null ||
      motherboard != null ||
      ram != null ||
      gpu != null ||
      ssd != null ||
      ssd != null ||
      cooler != null ||
      pcCase != null;

  prefillBuild(Build build, bool isGenerated) {
    isGenerated = isGenerated;
    cpu = build.cpu;
    motherboard = build.mb;
    ram = build.ram;
    gpu = build.gpu;
    psu = build.psu;
    cooler = build.cooler;
    ssd = build.ssd;
    pcCase = build.computerCase;
  }

  newBuild() {
    if (isGenerated != null && isGenerated) {
      isGenerated = false;
      cpu = null;
      ram = null;
      gpu = null;
      ssd = null;
      psu = null;
      cooler = null;
      pcCase = null;
    }
  }

  addCpu(Cpu cpu) {
    this.cpu = cpu;
    notifyListeners();
  }

  addMotherboard(Motherboard motherboard) {
    this.motherboard = motherboard;
    notifyListeners();
  }

  addRAM(RAM ram) {
    this.ram = ram;
    notifyListeners();
  }

  addVideoCard(VideoCard gpu) {
    this.gpu = gpu;
    notifyListeners();
  }

  addSSD(SSD ssd) {
    this.ssd = ssd;
    notifyListeners();
  }

  addPowerSupply(PowerSupply psu) {
    this.psu = psu;
    notifyListeners();
  }

  addCooler(Cooler cooler) {
    this.cooler = cooler;
    notifyListeners();
  }

  addCase(Case pcCase) {
    this.pcCase = pcCase;
    notifyListeners();
  }

  removeCPU() {
    cpu = null;
    notifyListeners();
  }

  removeMotherboard() {
    motherboard = null;
    notifyListeners();
  }

  removeVideoCard() {
    gpu = null;
    notifyListeners();
  }

  removeRAM() {
    ram = null;
    notifyListeners();
  }

  removeStorage() {
    ssd = null;
    notifyListeners();
  }

  removePSU() {
    psu = null;
    notifyListeners();
  }

  removeCooler() {
    cooler = null;
    notifyListeners();
  }

  removeCase() {
    pcCase = null;
    notifyListeners();
  }
}
