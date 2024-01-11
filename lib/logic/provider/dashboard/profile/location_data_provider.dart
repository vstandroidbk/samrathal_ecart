import 'package:flutter/material.dart';

import '../../../../data/model/dashboard/profile/location_data_model.dart';

class LocationProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _address;
  String? _city;
  String? _state;
  String? _zipCode;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  String? get address => _address;

  String? get city => _city;

  String? get state => _state;

  String? get zipCode => _zipCode;

  void setLocationData(LocationData newData) {
    _latitude = newData.latitude;
    _longitude = newData.longitude;
    _address = newData.address;
    _city = newData.city;
    _state = newData.state;
    _zipCode = newData.zipCode;
    notifyListeners();
  }

  void clearLocationData() {
    _latitude = null;
    _longitude = null;
    _address = null;
    _city = null;
    _state = null;
    _zipCode = null;
    notifyListeners();
  }
}
