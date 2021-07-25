import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/logic/best_build_counter.dart';
import 'package:pc_builder/providers/build_generation/logic/build_generator.dart';
import 'package:darq/darq.dart';

class BuildGeneratorProvider extends ChangeNotifier {
  ReceivePort port = ReceivePort();
  BuildGenerator _buildGenerator = BuildGenerator();

  int buildCount;
  BuildWeights weights;
  double generationProgress;

  List<Build> bestBuilds;

  LoadingProcess loading;

  _clearProperties() {
    bestBuilds = null;
    buildCount = null;
    weights = null;
    loading = null;
    generationProgress = null;
  }

  generateBuildsTOPSIS(BuildWeights weights, double maxBuildPrice) async {
    final stopwatch = Stopwatch()..start();
    _setWeightsAndPrice(weights, maxBuildPrice);
    await _buildGenerator.orderPartsByTopsis();
    loading = LoadingProcess.orderedParts;
    notifyListeners();

    var sendPort = await _spawnIsolate();

    var counters = _buildGenerator.getBuildCountersTOPSIS();

    var _builds = await _generateBuilds(sendPort, counters);

    loading = LoadingProcess.generatedBuilds;
    notifyListeners();

    bestBuilds = _buildGenerator.findBestBuildsByTopsis(_builds);

    loading = LoadingProcess.selectedBest;
    notifyListeners();
    stopwatch.stop();
  }

  generateBuildsWSM(BuildWeights weights, double maxBuildPrice) async {
    final stopwatch = Stopwatch()..start();
    _setWeightsAndPrice(weights, maxBuildPrice);
    await _buildGenerator.orderPartsByWSM();
    loading = LoadingProcess.orderedParts;
    notifyListeners();

    var sendPort = await _spawnIsolate();

    var counters = _buildGenerator.getBuildCountersWSM();

    var _builds = await _generateBuilds(sendPort, counters);

    loading = LoadingProcess.generatedBuilds;
    notifyListeners();

    bestBuilds = _buildGenerator.findBestBuildsByWSM(_builds);

    loading = LoadingProcess.selectedBest;
    notifyListeners();
    stopwatch.stop();
  }

  generateBuildsVIKOR(BuildWeights weights, double maxBuildPrice) async {
    final stopwatch = Stopwatch()..start();
    _setWeightsAndPrice(weights, maxBuildPrice);
    await _buildGenerator.orderPartsByVIKOR();
    loading = LoadingProcess.orderedParts;
    notifyListeners();

    var sendPort = await _spawnIsolate();

    var counters = _buildGenerator.getBuildCountersVIKOR();

    var _builds = await _generateBuilds(sendPort, counters);

    loading = LoadingProcess.generatedBuilds;
    notifyListeners();

    bestBuilds = _buildGenerator.findBestBuildsByVIKOR(_builds);

    loading = LoadingProcess.selectedBest;
    notifyListeners();
    stopwatch.stop();
  }

  _setWeightsAndPrice(BuildWeights weights, double maxBuildPrice) {
    _clearProperties();
    this.weights = weights;

    loading = LoadingProcess.countedWeights;
    notifyListeners();

    _buildGenerator.weights = weights;
    _buildGenerator.maxBuildPrice = maxBuildPrice;
  }

  Future<SendPort> _spawnIsolate() async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(isolateEntry, receivePort.sendPort);

    return await receivePort.first;
  }

  Future<List<Build>> _generateBuilds(SendPort sendPort, List<BestBuildCounter> counters) async {
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
    buildCount = _builds.length;
    notifyListeners();

    return _builds;
  }

  static isolateEntry(SendPort sendPort) async {
    ReceivePort port = ReceivePort();

    sendPort.send(port.sendPort);

    await for (var msg in port) {
      BestBuildCounter counter = msg[0];
      SendPort replyPort = msg[1];

      var builds = computeBestBuilds(counter);

      replyPort.send(builds);
    }
  }

  Future sendRecieve(SendPort send, message) {
    ReceivePort responsePort = ReceivePort();

    send.send([message, responsePort.sendPort]);
    return responsePort.first;
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

List<Build> computeBestBuilds(BestBuildCounter counter) {
  return counter.countBestBuilds();
}

enum LoadingProcess { countedWeights, orderedParts, generatedBuilds, selectedBest }
