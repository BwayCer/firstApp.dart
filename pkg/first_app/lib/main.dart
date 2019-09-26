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

  return new MaterialApp(
    // `title` 沒什麼用的意思
    //   * https://api.flutter.dev/flutter/material/MaterialApp/title.html
    //   * https://stackoverflow.com/questions/50615006/where-does-the-title-of-material-app-used-in-flutter
    title: '第一個 Flutter 應用程式',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new Scaffold(
      body: new Center(
        child: new Text('Hello World!'),
      ),
    ),
  );
}
