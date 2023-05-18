import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:rikedu/src/utils/constants/colors.dart';
import 'package:rikedu/src/features/parental_controls/views/map.dart';
import 'package:rikedu/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: RealtimeLocation()));
}

class RealtimeLocation extends StatefulWidget {
  const RealtimeLocation({super.key});

  @override
  _RealtimeLocationState createState() => _RealtimeLocationState();
}

class _RealtimeLocationState extends State<RealtimeLocation> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('live location tracker'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: const Text('add my location')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: const Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: const Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Column(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: SizedBox(
                                  height: 200,
                                  child: RealtimeMap(
                                      snapshot.data!.docs[index].id),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                    FluentIcons.full_screen_maximize_24_filled),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RealtimeMap(
                                          snapshot.data!.docs[index].id)));
                                },
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['latitude']
                                        .toString()),
                                    const VerticalDivider(
                                      color: rikeDarkColor,
                                      thickness: 0.5,
                                    ),
                                    Text(snapshot.data!.docs[index]['longitude']
                                        .toString()),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': locationResult.latitude,
        'longitude': locationResult.longitude,
        'name': 'john'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'john'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
