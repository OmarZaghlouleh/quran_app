// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quran/models/ayah_model.dart';
import 'package:quran/models/list_of_ayah_model.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchingSurah {
  Future<List<Ayah>> fetchFullSurah(int surahNumber) async {
    try {
      final response = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/surah/$surahNumber'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        ListOfAyah listOfAyah = ListOfAyah.fromJson(jsonData);
        List<Ayah> list =
            listOfAyah.listofAyah.map((e) => Ayah.fromJson(e)).toList();

        return list;
      } else {}
    } catch (e) {}
    return [];
  }

  Future<List<String>> fetchFullSurahAudio(
      int surahNumber, String reader) async {
    try {
      final response = await http.get(
          Uri.parse('http://api.alquran.cloud/v1/surah/$surahNumber/$reader'));
      final response2 = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/surah/1/$reader'));
      if (response.statusCode == 200 && response2.statusCode == 200) {
        var jsonData =
            jsonDecode(response.body)['data']['ayahs'] as List<dynamic>;
        var jsonData2 =
            jsonDecode(response2.body)['data']['ayahs'] as List<dynamic>;
        List<String> list = [];

        if (surahNumber != 1) list.add(jsonData2[0]['audio']);
        for (var element in jsonData) {
          list.add(element['audio']);
        }

        return list;
      } else {}
    } catch (e) {}
    return [];
  }

  Future<List<List<String>>> fetchFullQuranAudio(
      String reader, BuildContext context) async {
    List<List<String>> fullList = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var p = Provider.of<AyahsViewModel>(context, listen: false);
    if (sharedPreferences.getBool(reader) == false ||
        sharedPreferences.getBool(reader) == null) {
      for (int i = 1; i <= 114; i++) {
        p.increaseCurrentDownloading();

        final response = await http
            .get(Uri.parse('http://api.alquran.cloud/v1/surah/$i/$reader'));
        final response2 = await http
            .get(Uri.parse('http://api.alquran.cloud/v1/surah/1/$reader'));
        if (response.statusCode == 200 && response2.statusCode == 200) {
          var jsonData =
              jsonDecode(response.body)['data']['ayahs'] as List<dynamic>;
          var jsonData2 =
              jsonDecode(response2.body)['data']['ayahs'] as List<dynamic>;
          List<String> audioList = [];

          if (i != 1 && !audioList.contains(jsonData2[0]['audio']))
            audioList.add(jsonData2[0]['audio']);
          for (var element in jsonData) {
            audioList.add(element['audio']);
          }

          fullList.add(audioList);
        } else {}
      }

      for (int i = 0; i < fullList.length; i++) {
        sharedPreferences.setStringList('$reader surah$i', fullList[i]);
      }
      sharedPreferences.setBool(reader, true);

      p.eraseCurrentDownloadingNumber();
    } else {
      for (int i = 0; i < 114; i++) {
        fullList.add(sharedPreferences.getStringList('$reader surah$i') ?? []);
      }
    }

    return fullList;
  }
}
