// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print

import 'package:hive/hive.dart';

class Helper {
  late Box box;
  late Box box2;
  Helper() {
    openBox();
  }
  openBox() {
    box = Hive.box<Map>("money");
  }

  Future AddTodo(int money, String note, String type, DateTime date) async {
    var values = {
      "money": money,
      "note": note,
      "type": type,
      "date": date,
    };
    box.add(values);
  }
  Future<Map> fetch() async {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return await Future.value(box.toMap());
    }
  }
}
