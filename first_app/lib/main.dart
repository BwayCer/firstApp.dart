import 'package:flutter/material.dart';
import 'vul354/vul354.dart';

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
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 128.0,
                child: new Image.asset('assets/mmsetting/password.png'),
              ),
              new Padding(padding: const EdgeInsets.only(top: 5.0)),
              new Text(
                'Icon made by prettycons from www.flaticon.com',
                style: new TextStyle(
                  fontSize: 10.0,
                  color: Colors.brown,
                ),
              ),
            ],
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

class ApDrawer extends StatefulWidget {
  @override
  createState() => new ApDrawerState();
}

class ApDrawerState extends State<ApDrawer> {
  final vul354 = new Vul354();
  List<dynamic> _apXxx;

  void updateApXxx(List<dynamic> newApXxx) {
    setState(() {
      _apXxx = newApXxx;
    });
  }

  ApDrawerState() {
    vul354.readApXxx().then((List<dynamic> data) {
      updateApXxx(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('鍵值表'),
      ),
      body: (_apXxx?.isEmpty ?? true) ? emptyNotFound() : showData(),
    );
  }

  Widget emptyNotFound() {
    return new Center(
      child: new Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('assets/mmsetting/not-found.png'),
              new Padding(padding: const EdgeInsets.only(top: 5.0)),
              new Text(
                'Icon made by Freepik from www.flaticon.com',
                style: new TextStyle(
                  fontSize: 10.0,
                  color: Colors.brown,
                ),
              ),
              new Text(
                '未有任何資料',
                style: new TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showData() {
    return new ListView.builder(
      itemBuilder: (context, idx) {
        List<dynamic> item = _apXxx[idx];
        String name = item[0];
        // String description = item[1];
        Map<String, dynamic> detail = item[2];

        return ExpansionTile(
          title: new Text(name),
          children: detail.keys.map((key) {
            return new ListTile(
              title: new Text('$key :  ${detail[key]}'),
            );
          }).toList(),
        );
      },
      itemCount: _apXxx.length,
    );
  }
}
