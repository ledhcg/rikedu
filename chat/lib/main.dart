import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Internet Access Blocker',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: MyHomePage(),
);
}
}

class MyHomePage extends StatefulWidget {
@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
StreamSubscription<ConnectivityResult>? subscription;

@override
void initState() {
super.initState();
subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
if (result == ConnectivityResult.none) {
_disableInternetAccess();
}
});
}

@override
void dispose() {
super.dispose();
subscription?.cancel();
}

Future<void> _disableInternetAccess() async {
List<ProcessResult> results = [];
results.add(await Process.run('adb', ['shell', 'iptables', '-F']));
results.add(await Process.run('adb', ['shell', 'iptables', '-A', 'OUTPUT', '-p', 'tcp', '-j', 'DROP']));
results.add(await Process.run('adb', ['shell', 'iptables', '-A', 'OUTPUT', '-p', 'udp', '-j', 'DROP']));
results.forEach((result) {
print(result.stdout);
print(result.stderr);
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Internet Access Blocker'),
),
body: Center(
child: Text('This app will disable access to the internet from other apps when no connection is available.'),
),
);
}
}