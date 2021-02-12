import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/models/video_card.dart';

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
    var res = await _getSnapshot(_cpuCollection);
    cpuList = List();
    res.docs.forEach((doc) {
      cpuList += (doc.data()['cpus'] as List).map((e) => Cpu.fromJson(e)).toList();
    });
  }

  loadMotherboards() async {
    var res = await _getSnapshot(_motherboardCollection);
    res.docs.forEach((doc) {
      motherboardList =
          (doc.data()['motherboards'] as List).map((e) => Motherboard.fromJson(e)).toList();
    });
  }

  loadRam() async {
    var res = await _getSnapshot(_ramCollection);
    res.docs.forEach((doc) {
      ramList = (doc.data()['ram'] as List).map((e) => RAM.fromJson(e)).toList();
    });
  }

  loadCoolers() async {
    var res = await _getSnapshot(_coolerCollection);
    res.docs.forEach((doc) {
      coolerList = (doc.data()['coolers'] as List).map((e) => Cooler.fromJson(e)).toList();
    });
  }

  loadVideoCards() async {
    var res = await _getSnapshot(_videocardCollection);
    res.docs.forEach((doc) {
      videoCardList = (doc.data()['videocards'] as List).map((e) => VideoCard.fromJson(e)).toList();
    });
  }

  loadSSD() async {
    var res = await _getSnapshot(_ssdCollection);
    res.docs.forEach((doc) {
      ssdList = (doc.data()['ssd'] as List).map((e) => SSD.fromJson(e)).toList();
    });
  }

  loadCase() async {
    var res = await _getSnapshot(_caseCollection);
    res.docs.forEach((doc) {
      caseList = (doc.data()['cases'] as List).map((e) => Case.fromJson(e)).toList();
    });
  }

  loadPowerSupply() async {
    var res = await _getSnapshot(_powerSupplyCollection);
    res.docs.forEach((doc) {
      powerSupplyList = (doc.data()['psu'] as List).map((e) => PowerSupply.fromJson(e)).toList();
    });
  }

  Future<QuerySnapshot> _getSnapshot(CollectionReference collection) async {
    if (_motherboardCollection == null) await initialize();
    var res = await collection.get(GetOptions(source: Source.cache));
    if (res.docs.isEmpty) res = await collection.get();
    return res;
  }
}
