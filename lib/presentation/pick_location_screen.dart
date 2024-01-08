import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';

import '../data/dashboard/profile/location_data_model.dart';
import '../logic/provider/dashboard/profile/location_data_provider.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  //get map controller to access map
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatLng;
  String _draggedAddress = "";
  String _city = "";
  String _state = "";
  String _zipCode = "";
  Map<String, dynamic> addressMap = {};

  late LocationProvider _locationProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default LatLng for camera position
    _defaultLatLng = const LatLng(0, 0);
    _draggedLatLng = _defaultLatLng;
    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 17.5 // number of map view
            );
    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  bool onBackPressed() {
    _locationProvider.clearLocationData();
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose on map",
                style: AppTextStyles.bodyWhite18,
              ),
              3.ph,
              Text(
                "Drag the map to choose a place",
                style: AppTextStyles.bodyWhite14,
              ),
            ],
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      _showDraggedAddress(),
      confirmLocationButton(),
      currentLocationButton()
    ]);
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_draggedAddress.isNotEmpty)
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ),
              child: Center(
                child: Text(
                  _draggedAddress,
                  style: AppTextStyles.bodyBlack16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition: _cameraPosition!,
      //initialize camera position for map
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatLng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of LatLng
        _draggedLatLng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 75,
        child: Lottie.asset(AppImages.markerLottie),
      ),
    );
  }

  Widget confirmLocationButton() {
    return Positioned(
      bottom: 16,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            _locationProvider.setLocationData(LocationData(
              latitude: _draggedLatLng.latitude,
              longitude: _draggedLatLng.longitude,
              address: _draggedAddress,
              city: _city,
              state: _state,
              zipCode: _zipCode,
            ));
            Navigator.pop(context, addressMap);
          },
          isGradient: false,
          child: Text(
            "Confirm Location",
            style: AppTextStyles.bodyWhite14,
          ),
        ),
      ),
    );
  }

  Widget currentLocationButton() {
    return Positioned(
      bottom: 100,
      right: 10,
      child: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          mini: false,
          shape: const CircleBorder(),
          onPressed: () {
            _gotoUserCurrentPosition();
          },
          child: const Icon(
            Icons.my_location_sharp,
            size: 25,
          ),
        ),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    if(position.latitude ==0 || position.longitude==0){
      return;
    }
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placeMarks[0]; // get only first and closest address

    // "Name: ${address.name}, AdministrativeArea: ${address.administrativeArea}, Country: ${address.country}, IsoCountryCode: ${address.isoCountryCode}, Locality: ${address.locality}, PostalCode: ${address.postalCode}, Street: ${address.street},SubAdministrativeArea:  ${address.subAdministrativeArea}, SubLocality: ${address.subLocality} , SubThoroughfare: ${address.subThoroughfare}, Thoroughfare: ${address.thoroughfare}";
    String addressStr =
        "${address.name}, ${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.country}, (${address.postalCode})";
    setState(() {
      _draggedAddress = addressStr;
      _city = address.locality!;
      _state = address.administrativeArea!;
      _zipCode = address.postalCode!;
      addressMap.addAll({
        "address": addressStr,
        "state": _state,
        "city": _city,
        "zipCode": _zipCode,
      });
    });
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by LatLng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      await Geolocator.openLocationSettings();
      log("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        log("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      // locationPermission = await Permission.location.request();
      log("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
