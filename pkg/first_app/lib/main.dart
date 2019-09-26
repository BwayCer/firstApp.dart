import 'package:flutter/material.dart';

// 圖形介面的 Hello world!
// void main() => runApp(new Text(
//       'Hello World!',
//       textDirection: TextDirection.ltr,
//     ));

// 基於熱重載及時編譯 JIT 的改寫
// void main() => runApp(myAppBuild());
void main() {
  print('main() - 初始化時被執行');
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return myAppBuild();
  }
}

Widget myAppBuild() {
  print('MyApp#build() - 初始化及熱重載時被執行');

  return new Text(
    'Hello World!',
    textDirection: TextDirection.ltr,
  );
}
