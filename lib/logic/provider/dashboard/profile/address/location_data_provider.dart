import 'package:flutter/material.dart';
import '../../../../../data/model/dashboard/profile/address/location_data_model.dart';

class LocationProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _address;
  String? _city;
  String? _state;
  String? _zipCode;
  String? _landmark;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  String? get address => _address;

  String? get city => _city;

  String? get state => _state;

  String? get zipCode => _zipCode;

  String? get landmark => _landmark;

  void setLocationData(LocationData newData) {
    _latitude = newData.latitude;
    _longitude = newData.longitude;
    _address = newData.address;
    _city = newData.city;
    _state = newData.state;
    _zipCode = newData.zipCode;
    _landmark = newData.landmark;
    notifyListeners();
  }

  void clearLocationData() {
    _latitude = null;
    _longitude = null;
    _address = null;
    _city = null;
    _state = null;
    _zipCode = null;
    _landmark = null;
    notifyListeners();
  }
}
