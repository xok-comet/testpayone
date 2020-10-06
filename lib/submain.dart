import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payone/flutter_payone.dart';

class Submain extends StatefulWidget {
  @override
  _SubmainState createState() => _SubmainState();
}

class _SubmainState extends State<Submain> {
  String _responseObserve = 'Waiting for Response...';
  Future<void> startObserve() async {
    String response = "listening";
    setState(() {
      _responseObserve = response;
    });
    try {
      final result = await FlutterPayone.startObserve();
      response = result.toString();
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      _responseObserve = response;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
                child: Text('start listen'),
                onPressed: startObserve,
              ),
              Text(_responseObserve),
        ],
      ),
    );
  }
}