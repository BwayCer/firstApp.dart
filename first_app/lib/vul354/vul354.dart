import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Vul354 {
  String apPath = 'assets/repo/ap.json';
  List<dynamic> apXxx;

  Future<List> readApXxx() {
    return rootBundle.loadString(this.apPath).then((String fileContents) {
      apXxx = jsonDecode(fileContents);
      // print('${apXxx.runtimeType}: ${apXxx}');
      return apXxx;
    });
  }
}
