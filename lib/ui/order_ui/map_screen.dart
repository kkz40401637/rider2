import 'package:apitestinglogin/models/response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apitestinglogin/constants.dart';
import 'package:location/location.dart';
import 'package:apitestinglogin/utils/stream_ext.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/delivery_item_detail/delivery_item_detail.dart';
import '../../services/bloc/delivery_detail/delivery_detail.dart';
import 'package:apitestinglogin/models/orderListModel/new_order_model.dart';

class MapScreen extends StatefulWidget {

  List<NewOrderResultModel> orderList;
  Function(String orderId, int changeStatus) updateStatus;


  final String orderId;
   MapScreen (this.orderList, {required this.orderId,required this.updateStatus});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Map<String, bool> orderPickUp = {};

  GoogleMapController? _controller;
  final _bloc = DeliveryDetailBloc();

  static const LatLng sourceLocation = LatLng(16.8633899, 96.1205488);
  static const LatLng destination = LatLng(16.8223508, 96.1290521);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then(
      (location) {
        setState(
          () {
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
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints getPolyPoints = PolylinePoints();

    PolylineResult result = await getPolyPoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));

      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    _bloc.getDid(orderId: widget.orderId, lang: "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Track Order",
          ),
        ),
        body: currentLocation == null
            ? const Center(child: Text("Loading"))
            : GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
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
                      position: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!)),
                  Marker(
                    markerId: MarkerId("Source"),
                    position: sourceLocation,
                  ),
                  Marker(
                    markerId: MarkerId("Destination"),
                    position: destination,
                  ),
                },
              ),
        bottomNavigationBar: _bloc.didStream().streamWidget(
            successWidget: (ResponseModel responseModel) {
              DidModel model = responseModel.data;
              return ExpansionTile(
                title: Text(model.restaurant!.address!),
                childrenPadding: const EdgeInsets.all(10),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: const Color(0xffF2F2F7),
                    child: Text(
                      model.orderNo!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFF55F01),
                      ),
                    ),
                  ),
                  // REstaurant
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("PICKED UP AT"),
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color(0xFFF55F01),
                          fontWeight: FontWeight.w500,
                          letterSpacing:
                              context.locale == const Locale("my", "MM")
                                  ? null
                                  : 5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 3),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Ready at ${model.estimatedTime}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Text(
                    model.restaurant!.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.restaurant!.address!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0x80000000),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.restaurant!.phoneNo!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0x80000000),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFF55F01), shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            launchUrl(Uri(
                                scheme: 'tel',
                                path: model.restaurant!.phoneNo!));
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 10,
                    color: const Color(0xffF2F2F7),
                  ),
                  Text(
                    tr("ORDER SUMMARY"),
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFFF55F01),
                      fontWeight: FontWeight.w500,
                      letterSpacing:
                          context.locale == const Locale("my", "MM") ? null : 5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${model.orderItems![0].qty!}x",
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.orderItems![0].menuName!,
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.orderItems![0].price!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("Subtotal"),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.amount!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("Tax"),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.tax!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("Delivery Fee"),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.deliveryFees!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("Total"),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.totalAmount!.toString(),
                        style: const TextStyle(
                          color: Color(0x80000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child:  ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFF55F01),
                              ),
                              onPressed: () {
                                if (orderPickUp.containsKey(model.orderId)) {
                                  widget.updateStatus(model.orderId!, 3);
                                } else {
                                  setState(() {
                                    orderPickUp[model.orderId!] = true;
                                  });
                                }
                              },
                              child: Text(orderPickUp.containsKey(model.orderId)
                                  ? "Complete"
                                  : 'Pick Up')),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            tryAgain: () {}));
  }
}
