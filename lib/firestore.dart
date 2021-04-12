import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/models/video_card.dart';
/* import 'package:firedart/firedart.dart'; */
import 'package:shared_preferences/shared_preferences.dart';

/* class FireStore {
  CollectionReference _cpuCollection;
  CollectionReference _motherboardCollection;
  CollectionReference _videocardCollection;
  CollectionReference _ramCollection;
  CollectionReference _ssdCollection;
  CollectionReference _powerSupplyCollection;
  CollectionReference _coolerCollection;
  CollectionReference _caseCollection;

  List<Cpu> cpuList;
  List<Motherboard> motherboardList;
  List<RAM> ramList;
  List<VideoCard> videoCardList;
  List<SSD> ssdList;
  List<Case> caseList;
  List<PowerSupply> powerSupplyList;
  List<Cooler> coolerList;
  SharedPreferences prefs;

  static final FireStore _singleton = FireStore._internal();

  factory FireStore() {
    return _singleton;
  }

  FireStore._internal();

  initialize() async {
    /* await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance; */

    var firestore = Firestore.instance;

    prefs = await SharedPreferences.getInstance();

    _cpuCollection = firestore.collection('cputest');
    _motherboardCollection = firestore.collection('motherboard');
    _videocardCollection = firestore.collection('videocard');
    _ramCollection = firestore.collection('ram');
    _ssdCollection = firestore.collection('ssd');
    _powerSupplyCollection = firestore.collection('powersupply');
    _coolerCollection = firestore.collection('cooler');
    _caseCollection = firestore.collection('case');
  }

  loadCpus() async {
    cpuList = [];
    if (_cpuCollection == null) _cpuCollection = Firestore.instance.collection('cputest');
    var res = await _getSnapshot(_cpuCollection, "cpus");
    /* res.docs.forEach((doc) {
      cpuList += (doc.data()['cpus'] as List).map((e) => Cpu.fromJson(e)).toList();
    }); */

    cpuList = res.map((e) => Cpu.fromJson(e)).toList();
  }

  loadMotherboards() async {
    motherboardList = [];
    if (_motherboardCollection == null) await initialize();
    var res = await _getSnapshot(_motherboardCollection, "motherboards");
    /* res.docs.forEach((doc) {
      motherboardList +=
          (doc.data()['motherboards'] as List).map((e) => Motherboard.fromJson(e)).toList();
    }); */

    motherboardList = res.map((e) => Motherboard.fromJson(e)).toList();
  }

  loadRam() async {
    ramList = [];
    if (_ramCollection == null) await initialize();
    var res = await _getSnapshot(_ramCollection, "ram");
    /* res.docs.forEach((doc) {
      ramList += (doc.data()['ram'] as List).map((e) => RAM.fromJson(e)).toList();
    }); */

    ramList = res.map((e) => RAM.fromJson(e)).toList();
  }

  loadCoolers() async {
    coolerList = [];
    if (_coolerCollection == null) await initialize();
    var res = await _getSnapshot(_coolerCollection, "coolers");
    /* res.docs.forEach((doc) {
      coolerList += (doc.data()['coolers'] as List).map((e) => Cooler.fromJson(e)).toList();
    }); */

    coolerList = res.map((e) => Cooler.fromJson(e)).toList();
  }

  loadVideoCards() async {
    videoCardList = [];
    if (_videocardCollection == null) await initialize();
    var res = await _getSnapshot(_videocardCollection, "videocards");
    /* res.docs.forEach((doc) {
      videoCardList +=
          (doc.data()['videocards'] as List).map((e) => VideoCard.fromJson(e)).toList();
    }); */

    videoCardList = res.map((e) => VideoCard.fromJson(e)).toList();
  }

  loadSSD() async {
    ssdList = [];
    if (_ssdCollection == null) await initialize();
    var res = await _getSnapshot(_ssdCollection, "ssd");
    /* res.docs.forEach((doc) {
      ssdList += (doc.data()['ssd'] as List).map((e) => SSD.fromJson(e)).toList();
    }); */

    ssdList = res.map((e) => SSD.fromJson(e)).toList();
  }

  loadCase() async {
    caseList = [];
    if (_caseCollection == null) await initialize();
    var res = await _getSnapshot(_caseCollection, "cases");
    /* res.docs.forEach((doc) {
      caseList += (doc.data()['cases'] as List).map((e) => Case.fromJson(e)).toList();
    }); */
    caseList = res.map((e) => Case.fromJson(e)).toList();
  }

  loadPowerSupply() async {
    powerSupplyList = [];
    if (_powerSupplyCollection == null) await initialize();
    var res = await _getSnapshot(_powerSupplyCollection, "psu");
    /* res.docs.forEach((doc) {
      powerSupplyList += (doc.data()['psu'] as List).map((e) => PowerSupply.fromJson(e)).toList();
    }); */

    powerSupplyList = res.map((e) => PowerSupply.fromJson(e)).toList();
  }

  Future<List<dynamic>> _getSnapshot(CollectionReference collection, String key) async {
    /* if (collection == null) await initialize();
    var res = await collection.get(GetOptions(source: Source.cache));
    if (res.docs.isEmpty) res = await collection.get();
    return res; */

    /* if (collection == null) await initialize(); */
    List<dynamic> jsons = [];
    var res = prefs.getStringList(key);
    if (res == null || res.isEmpty) {
      var list = await collection.get();
      list.forEach((e) {
        jsons += e[key] as List;
      });
      prefs.setStringList(key, jsons.map((e) => json.encode(e)).toList());
    } else {
      jsons = res.map((e) => json.decode(e)).toList();
    }

    return jsons;
  }

  loadComponents() async {
    var loading = <Future>[];
    if (cpuList == null) loading.add(loadCpus());
    if (motherboardList == null) loading.add(loadMotherboards());
    if (coolerList == null) loading.add(loadCoolers());
    if (ramList == null) loading.add(loadRam());
    if (powerSupplyList == null) loading.add(loadPowerSupply());
    if (videoCardList == null) loading.add(loadVideoCards());
    if (caseList == null) loading.add(loadCase());
    if (ssdList == null) loading.add(loadSSD());

    await Future.wait(loading);
  }
} */

class FireStore {
  CollectionReference _cpuCollection;
  CollectionReference _motherboardCollection;
  CollectionReference _videocardCollection;
  CollectionReference _ramCollection;
  CollectionReference _ssdCollection;
  CollectionReference _powerSupplyCollection;
  CollectionReference _coolerCollection;
  CollectionReference _caseCollection;

  List<Cpu> cpuList;
  List<Motherboard> motherboardList;
  List<RAM> ramList;
  List<VideoCard> videoCardList;
  List<SSD> ssdList;
  List<Case> caseList;
  List<PowerSupply> powerSupplyList;
  List<Cooler> coolerList;
  SharedPreferences prefs;

  static final FireStore _singleton = FireStore._internal();

  factory FireStore() {
    return _singleton;
  }

  FireStore._internal();

  initialize() async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    _cpuCollection = firestore.collection('cputest');
    _motherboardCollection = firestore.collection('motherboard');
    _videocardCollection = firestore.collection('videocard');
    _ramCollection = firestore.collection('ram');
    _ssdCollection = firestore.collection('ssd');
    _powerSupplyCollection = firestore.collection('powersupply');
    _coolerCollection = firestore.collection('cooler');
    _caseCollection = firestore.collection('case');
  }

  loadCpus() async {
    cpuList = [];
    if (_cpuCollection == null) await initialize();
    var res = await _getSnapshot(_cpuCollection, "cpus");
    res.docs.forEach((doc) {
      cpuList += (doc.data()['cpus'] as List).map((e) => Cpu.fromJson(e)).toList();
    });
  }

  loadMotherboards() async {
    motherboardList = [];
    if (_motherboardCollection == null) await initialize();
    var res = await _getSnapshot(_motherboardCollection, "motherboards");
    res.docs.forEach((doc) {
      motherboardList +=
          (doc.data()['motherboards'] as List).map((e) => Motherboard.fromJson(e)).toList();
    });
  }

  loadRam() async {
    ramList = [];
    if (_ramCollection == null) await initialize();
    var res = await _getSnapshot(_ramCollection, "ram");
    res.docs.forEach((doc) {
      ramList += (doc.data()['ram'] as List).map((e) => RAM.fromJson(e)).toList();
    });
  }

  loadCoolers() async {
    coolerList = [];
    if (_coolerCollection == null) await initialize();
    var res = await _getSnapshot(_coolerCollection, "coolers");
    res.docs.forEach((doc) {
      coolerList += (doc.data()['coolers'] as List).map((e) => Cooler.fromJson(e)).toList();
    });
  }

  loadVideoCards() async {
    videoCardList = [];
    if (_videocardCollection == null) await initialize();
    var res = await _getSnapshot(_videocardCollection, "videocards");
    res.docs.forEach((doc) {
      videoCardList +=
          (doc.data()['videocards'] as List).map((e) => VideoCard.fromJson(e)).toList();
    });
  }

  loadSSD() async {
    ssdList = [];
    if (_ssdCollection == null) await initialize();
    var res = await _getSnapshot(_ssdCollection, "ssd");
    res.docs.forEach((doc) {
      ssdList += (doc.data()['ssd'] as List).map((e) => SSD.fromJson(e)).toList();
    });
  }

  loadCase() async {
    caseList = [];
    if (_caseCollection == null) await initialize();
    var res = await _getSnapshot(_caseCollection, "cases");
    res.docs.forEach((doc) {
      caseList += (doc.data()['cases'] as List).map((e) => Case.fromJson(e)).toList();
    });
  }

  loadPowerSupply() async {
    powerSupplyList = [];
    if (_powerSupplyCollection == null) await initialize();
    var res = await _getSnapshot(_powerSupplyCollection, "psu");
    res.docs.forEach((doc) {
      powerSupplyList += (doc.data()['psu'] as List).map((e) => PowerSupply.fromJson(e)).toList();
    });
  }

  _getSnapshot(CollectionReference collection, String key) async {
    if (collection == null) await initialize();
    var res = await collection.get(GetOptions(source: Source.cache));
    if (res.docs.isEmpty) res = await collection.get();
    return res;
  }

  loadComponents() async {
    var loading = <Future>[];
    if (cpuList == null) loading.add(loadCpus());
    if (motherboardList == null) loading.add(loadMotherboards());
    if (coolerList == null) loading.add(loadCoolers());
    if (ramList == null) loading.add(loadRam());
    if (powerSupplyList == null) loading.add(loadPowerSupply());
    if (videoCardList == null) loading.add(loadVideoCards());
    if (caseList == null) loading.add(loadCase());
    if (ssdList == null) loading.add(loadSSD());

    await Future.wait(loading);
  }
}
