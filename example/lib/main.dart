import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rxbus/flutter_rxbus.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    ///注册的方式使用
    RxBus.getInstance().register<int>((value) {
      print("注册int类型，收到value: $value");
    });

    ///返回指定类型的Observable，
    _subscription = RxBus.getInstance().toObservable<String>().listen((value) {
      print("返回String类型的Observable，收到value: $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_rxbus'),
      ),
      body: Center(child: Text("RxBus"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondPage();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    ///解除注册
    RxBus.getInstance().unregister<int>();
    ///取消注册
    _subscription?.cancel();
    super.dispose();
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () => RxBus.getInstance().post(1111),
            child: Text("发送int类型广播"),
          ),
          RaisedButton(
            onPressed: () => RxBus.getInstance().post("你好"),
            child: Text("发送String类型广播"),
          ),
        ],
      ),
    );
  }
}
