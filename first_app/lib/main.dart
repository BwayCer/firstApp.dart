import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'vul354/vul354.dart';

void main() {
  print('main() - 初始化時執行');
  runApp(new MyApp());
}

void devRun() async {
  // import 'dart:async';
  // new Timer(Duration(milliseconds: 1000), () {
  //   print('MyApp#build() - 計時器');
  // });

  Future<List> readApXxx() async {
    return Future.delayed(Duration(milliseconds: 999), () {
      apXxx = jsonDecode(apJsopTxt);
      return apXxx;
    });
  }

  // dynamic map(fn(String choA, String choB, Map<String, dynamic> choC), String a) {
  //   for (var idx = 0, len = this._apXxx.length; idx < len; idx++) {
  //     var item = this._apXxx[idx];
  //     String name = item[0];
  //     String description = item[1];
  //     Map<String, dynamic> detail = item[2];

  //     var rtnItem = fn(name, description, detail);
  //     print('${rtnItem.runtimeType}: ${rtnItem}');

  //     // print('$itemName: $itemDescribe');
  //     // for (var key in itemInfo.keys) {
  //     //   print('$key: ${item[key]}');
  //     // }
  //   }
  //   return 'null';
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp#build() - 初始化及熱重載時執行');
    devRun();

    return MaterialApp(
      // `title` 沒什麼用的意思
      //   * https://api.flutter.dev/flutter/material/MaterialApp/title.html
      //   * https://stackoverflow.com/questions/50615006/where-does-the-title-of-material-app-used-in-flutter
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
        // accentColor: Colors.cyan[600],
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
            if (key == '_url') {
              final url = detail[key];
              return new GestureDetector(
                child: new ListTile(
                  title: new Text(url),
                ),
                onTap: () async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              );
            } else {
              return new ListTile(
                title: new Text('$key :  ${detail[key]}'),
              );
            }
          }).toList(),
        );
      },
      itemCount: _apXxx.length,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.display1,
      //       ),
      //     ],
      //   ),
      // ),
      body: new Center(
        child: new Container(
          color: Theme.of(context).accentColor,
          child: new Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      floatingActionButton: new Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.yellow),
        child: new FloatingActionButton(
          onPressed: _incrementCounter,
          // tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
