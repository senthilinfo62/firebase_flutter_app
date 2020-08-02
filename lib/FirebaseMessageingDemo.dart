import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingDemo extends StatefulWidget {
  FirebaseMessagingDemo() : super();

  String title = "Firebase Messaging Demo";
  @override
  _FirebaseMessagingDemoState createState() => _FirebaseMessagingDemoState();
}

class _FirebaseMessagingDemoState extends State<FirebaseMessagingDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _messages;
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("DeviceToken: ${deviceToken}");
    });
  }

  _configureFirebaseListener() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage ${message}");
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch ${message}");
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume ${message}");
        _setMessage(message);
      },
      /*onBackgroundMessage: (Map<String, dynamic> message) async {
        print("onBackgroundMessage ${message}");
      },*/
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String nMessage = data['message'];
    setState(() {
      Message m = Message(title, body, nMessage);
      _messages.add(m);
    });
  }

  @override
  void initState() {
    super.initState();
    _messages = List<Message>();

    _getToken();
    _configureFirebaseListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: null == _messages ? 0 : _messages.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  _messages[index].message,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            );
          }),
    );
  }
}

class Message {
  String title;

  String body;
  String message;
  Message(this.title, this.body, this.message);
}
