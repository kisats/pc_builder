import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:darq/darq.dart';
import 'package:pc_builder/providers/build_generation/logic/best_build_counter.dart';
import 'package:pc_builder/providers/build_generation/logic/best_worst_method_logic.dart';
import 'package:pc_builder/providers/build_generation/logic/build_generator.dart';
import 'package:flutter/foundation.dart';

class AutoBuildProvider extends ChangeNotifier {
  BestWorstMethodLogic _bwLogic;
  BuildGenerator _buildGenerator;

  AutoBuildProvider() {
    _bwLogic = BestWorstMethodLogic();
    _buildGenerator = BuildGenerator();
    maxBuildPrice = 0;
  }

  ReceivePort port = ReceivePort();

  BestWorstValues bestValues, worstValues;

  int buildCount;
  BuildWeights weights;
  double generationProgress;

  List<Build> bestBuilds;
  double maxBuildPrice;

  LoadingProcess loading;

  generateBuilds() async {
    _clearProperties();
    weights = _bwLogic.countWeights(bestValues, worstValues);
    print("COUNTED WEIGHTS");
    loading = LoadingProcess.countedWeights;
    notifyListeners();
    _buildGenerator.weights = weights;
    _buildGenerator.maxBuildPrice = maxBuildPrice;
    await _buildGenerator.orderAllParts();
    print("ORDERED PARTS");
    loading = LoadingProcess.orderedParts;
    notifyListeners();

    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(isolateEntry, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

    var counters = _buildGenerator.getBuildCounters();

    generationProgress = 0;
    notifyListeners();

    var _builds = <Build>[]; 
    _builds += await sendRecieve(sendPort, counters[0]);
    generationProgress = 0.25;
    notifyListeners();

    _builds += await sendRecieve(sendPort, counters[1]);
    generationProgress = 0.5;
    notifyListeners();

    _builds += await sendRecieve(sendPort, counters[2]);
    generationProgress = 0.75;
    notifyListeners();

    _builds += await sendRecieve(sendPort, counters[3]);
    generationProgress = 1.0;
    notifyListeners();
    
    /* await for (var msg in receivePort){
      _builds += msg[0];
      if(generationProgress == null)
      generationProgress = 0.25;
      else
      generationProgress += 0.25;
      print("GENERATED BUILDS");
      loading = LoadingProcess.generatedBuilds;
      notifyListeners();

      if(generationProgress == 1){
        bestBuilds = _buildGenerator.findBestBuildsByTopsis(_builds);
        loading = LoadingProcess.selectedBest;
        print("SELECTED BEST BUILDS");
        notifyListeners();
      }
      
    } */
    // await Future.delayed(Duration(seconds: 1));
    // //buildCount = await _buildGenerator.generateBuilds();
    // generationProgress = 0;
    // notifyListeners();
    // await Future.delayed(Duration(milliseconds: 300));
    // var _builds = <Build>[];
    // /* var isolate = await FlutterIsolate.spawn(computeBestBuilds, counters[0]); */
    // _builds += /* await compute( */computeBestBuilds(counters[0]);/* , counters[0]); */
    
    // generationProgress = 0.25;
    // notifyListeners();
    // await Future.delayed(Duration(milliseconds: 300));
    // /* _builds += await compute(computeBestBuilds, counters[1]); */
    // _builds += /* await compute( */computeBestBuilds(counters[1]);/* , counters[0]); */
    
    // generationProgress = 0.5;
    // notifyListeners();
    // await Future.delayed(Duration(milliseconds: 300));
    // /* _builds += await compute(computeBestBuilds, counters[2]); */
    // _builds += /* await compute( */computeBestBuilds(counters[2]);/* , counters[0]); */
    
    // generationProgress = 0.75;
    // notifyListeners();
    // await Future.delayed(Duration(milliseconds: 300));
    // /* _builds += await compute(computeBestBuilds, counters[3]); */
    // _builds += /* await compute( */computeBestBuilds(counters[3]);/* , counters[0]); */
    // generationProgress = 1.0;
    buildCount = _builds.length;
    notifyListeners();
    print("GENERATED BUILDS");
    loading = LoadingProcess.generatedBuilds;
    notifyListeners();
    bestBuilds = _buildGenerator.findBestBuildsByTopsis(_builds);
    loading = LoadingProcess.selectedBest;
    print("SELECTED BEST BUILDS");
    notifyListeners();
  }

  Future loadIsolate() async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(isolateEntry, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

  }

  static isolateEntry(SendPort sendPort) async {
    ReceivePort port = ReceivePort();

    sendPort.send(port.sendPort);

    await for (var msg in port){
      BestBuildCounter counter = msg[0];
      SendPort replyPort = msg[1];

      var builds = computeBestBuilds(counter);

      replyPort.send(builds);
    }
  }

  Future sendRecieve(SendPort send, message){
    ReceivePort responsePort = ReceivePort();

    send.send([message, responsePort.sendPort]);
    return responsePort.first;
  }

  _clearProperties() {
    bestBuilds = null;
    buildCount = null;
    weights = null;
    loading = null;
    generationProgress = null;
  }

  setBestParameters(BestWorstValues values) {
    bestValues = values;
    notifyListeners();
  }

  setWorstParameters(BestWorstValues values) {
    worstValues = values;
    notifyListeners();
  }

  setMaxPrice(double maxPrice) {
    maxBuildPrice = maxPrice;
    notifyListeners();
  }

  double getMaxWeight() {
    if (weights != null) {
      return [
        weights.price,
        weights.consumption,
        weights.contentCreation,
        weights.gaming,
        weights.multitasking,
        weights.storage
      ].max();
    } else
      return 1.0;
  }
}

List<Build> computeBestBuilds(BestBuildCounter counter){
  print("stariting counter" + counter.name);
  return counter.countBestBuilds();
}

enum LoadingProcess{
  countedWeights,
  orderedParts,
  generatedBuilds,
  selectedBest
}
