import 'dart:convert';

String apJsopTxt = '''[
  [
    "Item A",
    "Description of A",
    {
      "ZpWHdb*": "68hBZEV",
      "\$2tWjxc": "Dx4wZwR",
      "ygR%Tda": "FraNaN8",
      "gMZUzvH": "kLP&%wX",
      "BhuxX^M": "R5Ve@qA",
      "p5Zf\$RH": "N4BBJ&S"
    }
  ],
  [
    "Item B",
    "Description of B",
    {
      "9X7ke6N": "fk@62*4",
      "@xSvuzc": "WQnHzT^",
      "&7vzkHy": "VN2D9NR",
      "PWKF8aa": "sZCa^yW",
      "rcw355\$": "x^%kSnt",
      "ctM2H4w": "JL6\$YLj",
      "AjJs*DA": "vC8HHQK",
      "3N3WJbv": "%9g@pak"
    }
  ]
]''';

class Vul354 {
  List<dynamic> apXxx;

  Future<List> readApXxx() async {
    return Future.delayed(Duration(milliseconds: 999), () {
      apXxx = jsonDecode(apJsopTxt);
      return apXxx;
    });
  }
}
