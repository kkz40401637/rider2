

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apitestinglogin/constants.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {


  GoogleMapController? _controller;

  static const LatLng sourceLocation = LatLng(16.8633899,96.1205488);
  static const LatLng destination = LatLng(16.8223508, 96.1290521);

  List<LatLng> polylineCoordinates= [];
  LocationData? currentLocation;

  void getCurrentLocation () {
    Location location = Location();
    location.getLocation().then((location){
      setState((){
        currentLocation = location;
      },
      );
      // location.onLocationChanded.listen((newLoc) {
      //   (newLoc) {
      //     currentLocation = newLoc;
      //     setState((){
      //
      //     });
      //   };
      // });
    },);
  }





  void getPolyPoints() async {
    PolylinePoints getPolyPoints = PolylinePoints();

    PolylineResult result = await getPolyPoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),

    );

    if(result.points.isNotEmpty) {
      result.points.forEach(
              (PointLatLng point) => polylineCoordinates.add (
              LatLng(point.latitude, point.longitude)
          )
      );

      setState((){

      });
    }
  }


  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Track Order",
        ),
      ),
      body:
       currentLocation == null ? const Center(child: Text("Loading")):
      GoogleMap(
          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
          initialCameraPosition: CameraPosition(

              target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 14.5),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: primaryColor,
              width: 6,
            )
          },
          markers: {
            Marker(
                markerId: MarkerId("currentLocation"),
                position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
            ),

            Marker(
              markerId:  MarkerId("Source"),
              position: sourceLocation,
            ),
            Marker(
              markerId:  MarkerId("Destination"),
              position: destination,
            ),
          }



      ),


    );
  }
}
