import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:rikedu/src/utils/constants/file_strings.dart';

class RealtimeMap extends StatefulWidget {
  final String user_id;
  const RealtimeMap(this.user_id, {super.key});
  @override
  _RealtimeMapState createState() => _RealtimeMapState();
}

class _RealtimeMapState extends State<RealtimeMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('location').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          realtimeMap(snapshot);
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          compassEnabled: false,
          markers: {
            Marker(
              position: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['longitude'],
              ),
              markerId: const MarkerId('id'),
              icon: locationMarker,
            )
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 16,
            tilt: 45.0,
          ),
          onMapCreated: (GoogleMapController controller) async {
            String value =
                await DefaultAssetBundle.of(context).loadString(mapLight);
            setState(() {
              _controller = controller;
              _controller.setMapStyle(value);
              _added = true;
            });
          },
        );
      },
    ));
  }

  void setLocationMarker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, iconMarker)
        .then((marker) => locationMarker = marker);
  }

  @override
  void initState() {
    super.initState();
    setLocationMarker();
  }

  Future<void> realtimeMap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.user_id)['latitude'],
        snapshot.data!.docs.singleWhere(
            (element) => element.id == widget.user_id)['longitude'],
      ),
      zoom: 16,
      tilt: 45.0,
    )));
  }
}
