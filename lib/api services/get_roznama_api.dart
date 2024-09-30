// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:quran/component/location_details.dart';
import 'package:quran/models/roznama_model.dart';

class FetchRoznama {
  late Position position;

  Future<bool> getLocation() async {
    log("Location");
    try {
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.unableToDetermine) {
        locationPermission = await Geolocator.requestPermission();
      }
      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<LocationDetails> getLocationDetails() async {
    try {
      log(position.longitude.toString());
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty)
        return LocationDetails(
            city: placemarks.first.locality ?? "Damascus",
            country: placemarks.first.country ?? "Syria");
      else
        return LocationDetails(city: "Damascus", country: "Syria");
    } catch (e) {
      return LocationDetails(city: "Damascus", country: "Syria");
    }
  }

  Future<Roznama> fetchRoznama() async {
    Roznama defaultHijri = Roznama.empty();
    try {
      final location = await getLocation();
      LocationDetails locationD = await getLocationDetails();
      log(locationD.city);
      if (location == false) return defaultHijri;
      DateTime datetime = DateTime.now();
      final date = "${datetime.day}-${datetime.month}-${datetime.year}";
      log(date.toString());
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/timingsByCity/$date?city=${locationD.city}&country=${locationD.country}&method=4'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        Roznama hijriCalendar = Roznama.fromJson(jsonData);
        hijriCalendar.city = locationD.city;
        hijriCalendar.country = locationD.country;
        return hijriCalendar;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return defaultHijri;
  }
}
