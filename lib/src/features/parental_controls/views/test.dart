import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/file_strings.dart';
import 'package:rikedu/src/features/parental_controls/views/battery.dart';
import 'package:rikedu/src/features/parental_controls/views/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: TestRealtimeLocation()));
}

class TestRealtimeLocation extends StatefulWidget {
  const TestRealtimeLocation({super.key});

  @override
  _TestRealtimeLocationState createState() => _TestRealtimeLocationState();
}

class _TestRealtimeLocationState extends State<TestRealtimeLocation> {
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
      body: Column(
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox(
                      height: 500,
                      child: RealtimeMap(snapshot.data!.docs[0].id),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(FluentIcons.full_screen_maximize_24_filled),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RealtimeMap(snapshot.data!.docs[0].id)));
                    },
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    left: 20,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: rikeLightColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(126.0),
                                child: Image.asset(avatarDefault),
                                // child: imageUrl != ''
                                //     ? Image.network(
                                //         imageUrl,
                                //         width: 126,
                                //         height: 126,
                                //         fit: BoxFit.fill,
                                //       )
                                //     : const Icon(
                                //         Icons.group_rounded,
                                //         size: 35,
                                //         color: rikePrimaryColor,
                                //       ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, top: 8.0, bottom: 4.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 50,
                                      child: Text(
                                        'Emily\'s Phone',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    // const Positioned(
                                    //   bottom: 0,
                                    //   child: BatteryPage(),
                                    // ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      height: 50,
                                      child: const BatteryPage(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
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
