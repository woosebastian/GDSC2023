// ignore_for_file: non_constant_identifier_names, sort_child_properties_last, avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: Center(
            child: deviceOrientation == Orientation.portrait
                ? const MapsPortrait() //changed this just for debugging, will change back to MapPortrait
                : const MapsLandscape()));
  }
}

class MapsPortrait extends StatefulWidget {
  const MapsPortrait({super.key});

  @override
  State<MapsPortrait> createState() => _MapsPortraitState();
}

class _MapsPortraitState extends State<MapsPortrait> {
  var coords = [];
  var selectedMarker_Address = "";
  var selectedMarker_Name = "";
  var selectedMarker_Subtitle = "";
  List<dynamic> selectedMarker_Services = <dynamic>[];

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; //map of all markers

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify['Location'].latitude, specify['Location'].longitude),
        infoWindow: InfoWindow(title: specify['Name']),
        onTap: () {
          setState(() {
            //For updating info box
            selectedMarker_Address = specify["Address"];
            selectedMarker_Name = specify["Name"];
            selectedMarker_Subtitle = specify["Subtitle"];
            selectedMarker_Services = specify["Services"];
          });
        });
    setState(() {
      markers[markerId] = marker;
    });
  }

//get markers from firestore
  getMarkerData() async {
    FirebaseFirestore.instance
        .collection('Health Center Coordinates')
        .get()
        .then((myMockData) {
      if (myMockData.docs.isNotEmpty) {
        for (int i = 0; i < myMockData.docs.length; i++) {
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
          //go through every location and create marker
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

//main layout ===============================================================
  @override
  Widget build(BuildContext context) {
    return Column(children: [
//https://www.youtube.com/watch?v=ctOcXmUZOZo - tutorial im following rn

      //THE ACTUAL MAP
      SizedBox(
        height: 350,
        child: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(36.9741, -122.0308),
            zoom: 12.0,
          ),
          onMapCreated: _onMapCreated,
        ),
      ),

      //Info underneath map
      buildInfoCard(
          selectedMarker_Address,
          selectedMarker_Name,
          selectedMarker_Subtitle,
          buildServicesSection(selectedMarker_Services)),
      Container()
    ]);
  }

//map interaction
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller = controller;
    });
  }
}

//subwidget with services included==================================================
Widget buildServicesSection(List<dynamic> servicesList) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(3, 3),
            )
          ]),
      child: Column(
        children: const [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ));
}

//build card with all the info====================================================

Widget buildInfoCard(
    String address, String name, String subtitle, Widget services) {
  return Container(
    height: 330,
    margin: const EdgeInsets.fromLTRB(20, 30, 20, 5),
    child: Column(
      children: [
        Container(
          child: Text(
            //Title
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
            textAlign: TextAlign.end,
          ),
          alignment: Alignment.centerLeft,
          width: double.infinity,
        ),
        const SizedBox(
          //Padding
          height: 10,
        ),
        Container(
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
          alignment: Alignment.centerLeft,
          width: double.infinity,
        ),
        const SizedBox(
          //Padding
          height: 20,
        ),
        Container(
          child: Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.end,
          ),
          alignment: Alignment.centerLeft,
          width: double.infinity,
        ),
        const SizedBox(
          //Padding
          height: 20,
        ),
        services,
      ],
    ),
  );
}

//Landscape View ==================================================================

class MapsLandscape extends StatelessWidget {
  const MapsLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 525,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(60, 20, 0, 20)),
      Container(
          width: 265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 5, 20)),
    ]);
  }
}
