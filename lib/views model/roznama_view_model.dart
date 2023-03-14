import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:quran/api%20services/get_roznama_api.dart';
import 'package:quran/models/roznama_model.dart';

class RoznamaViewModel with ChangeNotifier {
  Roznama? _hijriCalendar;
  bool _isInitialized = false;
  bool isLoading = false;
  Future<void> getRoznama() async {
    log("Called");

    isLoading = true;
    _hijriCalendar = await FetchRoznama().fetchRoznama();
    _isInitialized = true;
    isLoading = false;
    notifyListeners();
  }

  void reset() {
    _isInitialized = false;
  }

  Roznama get getCalendar =>
      _hijriCalendar ?? Roznama('', '', '', '', '', '', '', '', '', '', '', '');
  bool get isInitilized => _isInitialized;
}
