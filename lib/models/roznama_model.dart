// ignore_for_file: avoid_print

import 'dart:developer';

class Roznama {
  late String sunrise;
  late String fajr;
  late String duhr;
  late String asr;
  late String sunset;
  late String maghrib;
  late String isha;
  late String city;
  late String country;
  late String gregorianDate;
  late String hijriDate;
  late String timezone;

  Roznama(
      this.sunrise,
      this.fajr,
      this.duhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha,
      this.city,
      this.country,
      this.gregorianDate,
      this.hijriDate,
      this.timezone);

  factory Roznama.empty() =>
      Roznama("", "", "", "", "", "", "", "", "", "", "", "");

  Roznama.fromJson(Map jsonData) {
    log(jsonData.toString());
    sunrise = jsonData['timings']['Sunrise'] ?? '';
    fajr = jsonData['timings']['Fajr'] ?? '';
    duhr = jsonData['timings']['Dhuhr'] ?? '';
    asr = jsonData['timings']['Asr'] ?? '';
    sunset = jsonData['timings']['Sunset'] ?? '';
    maghrib = jsonData['timings']['Maghrib'] ?? '';
    isha = jsonData['timings']['Isha'] ?? '';

    // city = jsonData['location']['country'] ?? '';
    // country = jsonData['location']['country_code'] ?? '';
    timezone = jsonData['meta']['timezone'] ?? '';
    gregorianDate = jsonData['date']['gregorian']['date'] ?? "";
    hijriDate = jsonData['date']['hijri']['date'] ?? "";
  }
}
