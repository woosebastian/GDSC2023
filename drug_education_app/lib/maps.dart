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

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify['Location'].latitude, specify['Location'].longitude),
        infoWindow: InfoWindow(title: specify['Name']));
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
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

//list of coordinate marker
  Set<Marker> getMarker() {
    return <Marker>{
      const Marker(
          markerId: MarkerId('Center 1'),
          position: LatLng(36.97060924734167, -122.03334232319105),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'idk')),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
//https://www.youtube.com/watch?v=sL74UNLssV8 - tutorial im following rn
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

      Container(
          height: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 5)),
    ]);
  }

//map interaction
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller = controller;
    });
  }
}

// class MapsPortrait extends StatelessWidget {
//   const MapsPortrait({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
// //https://www.youtube.com/watch?v=sL74UNLssV8 - tutorial im following rn
//       //THE ACTUAL MAP
//       const SizedBox(
//         height: 350,
//         child: GoogleMap(
//             mapType: MapType.normal,
//             myLocationEnabled: true,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(36.9741, -122.0308),
//               zoom: 12.0,
//             )
//             onMapCreated: _onMapCreated,
//             ),
//       ),

//       Container(
//           height: 330,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.grey,
//           ),
//           margin: const EdgeInsets.fromLTRB(20, 20, 20, 5)),
//     ]);
//   }
//}

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


//IGNORE EVERYTHING BELOW THIS LINE BUT PLS DONT DELETE YET TY <3 ===========================================
//The actual map itself - TEMPORARY, WILL REMOVE LATER, TRYING SOMETHING NEW RN, DW ABOUT IT
//TUTORIAL: https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#3
// class MapSample extends StatefulWidget {
//   const MapSample({super.key});

//   @override
//   State<MapSample> createState() => _MapSampleState();
// }

// class _MapSampleState extends State<MapSample> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.52, 122.677433);
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           useMaterial3: true,
//           colorSchemeSeed: Colors.green[700],
//         ),
//         home: Scaffold(
//             body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         )));
//   }
// }
