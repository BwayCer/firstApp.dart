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
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Text(
            '首頁',
            style: new TextStyle(
              fontSize: 48.0,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60.0,
          color: Colors.yellow,
          child: new RaisedButton(
            child: new Text(
              '進入',
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.grey[100],
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            color: Colors.blue,
            onPressed: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new ApDrawer(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ApDrawer extends StatelessWidget {
  List<dynamic> _apXxx;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('鍵值表'),
      ),
      // TODO 不能加 new
      // body: (_apXxx?.isEmpty ?? true) ? emptyNotFound() : showData(),
      body: emptyNotFound(),
    );
  }

  Widget emptyNotFound() {
    return new Center(
      child: new Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: new Text(
          '未有任何資料',
          style: new TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
