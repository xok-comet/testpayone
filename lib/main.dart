import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payone/Constants.dart';
import 'package:flutter_payone/flutter_payone.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:testpayone/submain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _responseInitStore = 'Waiting for Response...';
  String _responseQrcode = 'Waiting for Response...';
  void initstore() {
    //var test = FlutterPayone.platformVersion
    FlutterPayone.initStore("mch5e436d803c35d",FlutterPayone.getProvinceCode(Province.vientiane),"sub-c-91489692-fa26-11e9-be22-ea7c5aada356","24123",FlutterPayone.getCountryCode(Country.lao),"BCEL","ONEPAY");
  }

  Future<Void> buildqrcode() async{
    String response = "";

    try {
      // final result = await platform.invokeMethod('initStore', stringParams);
      final result = await FlutterPayone.buildQrcode(1,FlutterPayone.getCurrencyCode(Currency.laoKip),"test");
      response = result.toString();
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }

    setState(() {
      _responseQrcode = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('init store'),
                onPressed: initstore,
              ),
              RaisedButton(
                child: Text('build qrcode'),
                onPressed: buildqrcode,
              ),
              QrImage(
                data: _responseQrcode,
                version: QrVersions.auto,
                size: 200.0,
              ),
              RaisedButton(
                child: Text('start submain'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Submain()),
                  );
                },
              ),
            ],
          ),
        ));
    
  }
}
