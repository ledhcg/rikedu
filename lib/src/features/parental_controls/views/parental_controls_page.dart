import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:rikedu/src/utils/constants/file_strings.dart';
import 'package:rikedu/src/features/parental_controls/views/battery.dart';
import 'package:rikedu/src/features/parental_controls/views/map.dart';

class ParentalControlsPage extends StatefulWidget {
  const ParentalControlsPage({super.key});

  @override
  _ParentalControlsPageState createState() => _ParentalControlsPageState();
}

class _ParentalControlsPageState extends State<ParentalControlsPage> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  late Color _cardColor;
  late Color _onCardColor;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _cardColor = Theme.of(context).colorScheme.primaryContainer;
    _onCardColor = Theme.of(context).colorScheme.onSurface;
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
              return SizedBox(
                height: size.height,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.5),
                      child: RealtimeMap(snapshot.data!.docs[0].id),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.4),
                      width: size.width,
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.35),
                            spreadRadius: 10,
                            blurRadius: 15,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GridView.count(
                        crossAxisCount: 2, // Số lượng cột
                        padding: const EdgeInsets.all(20), // Khoảng cách
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.85), // Màu nền của ô vuông
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          FluentIcons.apps_48_regular,
                                          size: 50,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                      Text(
                                        'App usage',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ],
                                  ), // Nội dung bên trong ô vuông
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.85), // Màu nền của ô vuông
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          FluentIcons.alert_urgent_24_regular,
                                          size: 50,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                      Text(
                                        'News',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ],
                                  ), // Nội dung bên trong ô vuông
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.85), // Màu nền của ô vuông
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          FluentIcons.book_contacts_28_regular,
                                          size: 50,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                      Text(
                                        'Results',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ],
                                  ), // Nội dung bên trong ô vuông
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.85), // Màu nền của ô vuông
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          FluentIcons.book_pulse_24_regular,
                                          size: 50,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                      Text(
                                        'Analytics',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //   icon: const Icon(
                    //       FluentIcons.full_screen_maximize_24_filled),
                    //   onPressed: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) =>
                    //             RealtimeMap(snapshot.data!.docs[0].id)));
                    //   },
                    // ),
                    Positioned(
                      top: 50,
                      right: 20,
                      left: 20,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: _cardColor,
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
                                  // child: Image.network(
                                  //     'https://picsum.photos/seed/avatar/600/600.webp'),
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
                                          'Emily phone',
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
                ),
              );
            },
          ),
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
