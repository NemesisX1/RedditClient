import 'dart:developer';
import 'package:redditech/models/appuser.model.dart';
import 'package:redditech/services/base.service.dart';
import 'package:hive/hive.dart';

/// [LocalService]
/// A base class to interact with local storage with Hive

class HiveClassName {
  static const String user = "user";
  static const String token = "token";
}

class LocalService extends BaseService {
  save<T extends HiveObject>(T data, String className) async {
    try {
      await Hive.openBox<T>(className);
    } catch (e) {
      log(e.toString());
    }
    Box<T> box = Hive.box(className);
    if (box.isNotEmpty) {
      await box.putAt(0, data);
    } else {
      await box.add(data);
    }
  }

  T? readData<T extends HiveObject>(String className) {
    try {
      Hive.openBox<T>(className);
    } catch (e) {
      log(e.toString());
    }
    Box<T> box = Hive.box(className);
    T? data = box.get(0);
    return data;
  }

  void deleteBoxes(String className) {
    Box<AppUser> box = Hive.box(className);
    box.deleteFromDisk();
  }
}
