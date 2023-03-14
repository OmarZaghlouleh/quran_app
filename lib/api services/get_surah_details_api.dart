// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/models/list_of_surah_model.dart';
import 'package:quran/models/surah_model.dart';

class FetchingSurahDetails {
  List<Surah> list = [];

  Future<List<Surah>> getSurahDetails(BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));
      if (response.statusCode == 200) {
        var surahDetailsInJson = jsonDecode(response.body);
        ListOfSurah listOfSurah = ListOfSurah.fromJson(surahDetailsInJson);
        List<Surah> allSurah =
            listOfSurah.listOfSurah.map((e) => Surah.fromJson(e)).toList();

        return allSurah;
      } else {
        showbanner(context, 'تحقق من اتصالك بالانترنيت');
      }
    } catch (e) {
      showbanner(context, 'تحقق من اتصالك بالانترنيت');
    }
    return [];
  }
}
