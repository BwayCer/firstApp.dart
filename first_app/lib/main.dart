import 'package:flutter/material.dart';

void main() {
  print('main() - 初始化時執行');
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp#build() - 初始化及熱重載時執行');

    return MaterialApp(
      // `title` 沒什麼用的意思
      //   * https://api.flutter.dev/flutter/material/MaterialApp/title.html
      //   * https://stackoverflow.com/questions/50615006/where-does-the-title-of-material-app-used-in-flutter
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        body: new Center(
          child: new Text('Hello World'),
        ),
      ),
    );
  }
}
