import 'package:flutter/cupertino.dart';

import 'package:quran/api%20services/get_surah_details_api.dart';
import 'package:quran/models/surah_model.dart';

class ListOfSurahViewModel with ChangeNotifier {
  List<Surah> listOfSurah = [];

  Future<void> getSurahDetails(BuildContext context) async {
    listOfSurah = await FetchingSurahDetails().getSurahDetails(context);
    notifyListeners();
  }

  List<Surah> get getListofSurah => listOfSurah;
}
