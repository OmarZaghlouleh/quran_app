// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/api%20services/get_full_surah_api.dart';

import 'package:quran/component/constants.dart';
import 'package:quran/models/ayah_model.dart';

class AyahsViewModel with ChangeNotifier {
  List<Ayah> _ayahs = [];
  List<String> _surahAudio = [];
  List<List<String>> _fullQuranAudio = [];
  //final player = AudioPlayer();
  IconData playIcon = EvaIcons.playCircle;
  String _reader = "ar.alafasy";
  String _fullQuranReader = "ar.alafasy";
  bool isLoading = false;
  bool fullQuranisLoading = false;
  bool donwloadLoading = false;
  int _surahNum = 1;
  int currentPlaying = 0;
  int _currentDownloading = 1;
  bool showUpDownFloating = true;
  bool firstTime = false;

  setFirstTime() {
    firstTime = true;
  }

  setshowUpDownFloating(bool value) {
    showUpDownFloating = value;
    notifyListeners();
  }

  void eraseFullQuran() {
    _fullQuranAudio = [];
    notifyListeners();
  }

  void increaseCurrentDownloading() {
    if (_currentDownloading < 114) _currentDownloading++;
    notifyListeners();
  }

  void eraseCurrentDownloadingNumber() {
    _currentDownloading = 1;
    notifyListeners();
  }

  int get getCurrentDownloading => _currentDownloading;

  void setDownloadLoading(bool value) {
    donwloadLoading = value;
    notifyListeners();
  }

  void setSurahNum(int value) {
    _surahNum = value;
    notifyListeners();
  }

  int get getSurahNumber => _surahNum;

  Future<void> getSurah(int surahNumber) async {
    _ayahs = await FetchingSurah().fetchFullSurah(surahNumber);
    _ayahs[0].text = _ayahs[0].text.replaceFirst(
        "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
        "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n");

    notifyListeners();
  }

  Future<void> getSurahAudio(int surahNumber) async {
    _surahAudio =
        await FetchingSurah().fetchFullSurahAudio(surahNumber, _reader);
    isLoading = false;

    setAudioSource();
    notifyListeners();
  }

  Future<void> getAlFatehaAudioSource() async {
    await getSurahAudio(1);
    setAudioSource();
  }

  void setTimer() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (player.audioSource != null && player.currentIndex != null) {
        if (player.audioSource!.sequence.elementAt(player.currentIndex!).tag ==
            'Stop') {
          setFullQuranAudioSource(
              getCurrentPlaying + 1 > 114 ? 0 : getCurrentPlaying + 1);
        } else {}
      } else {}
    });
  }

  Future<void> getFullQuranAudio(BuildContext context) async {
    fullQuranisLoading = true;
    donwloadLoading = true;
    _fullQuranAudio =
        await FetchingSurah().fetchFullQuranAudio(_fullQuranReader, context);

    fullQuranisLoading = false;
    // if (!player.playing && player.audioSource != null && !donwloadLoading)
    setFullQuranAudioSource(0);
    donwloadLoading = false;
    try {} catch (e) {}
    fullQuranisLoading = false;
    donwloadLoading = false;
    setTimer();

    notifyListeners();
  }

  void setAudioSource() {
    player.setAudioSource(ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: _surahAudio
            .map((e) =>
                AudioSource.uri(Uri.parse(e), tag: MediaItem(id: e, title: '')))
            .toList()));
    player.setLoopMode(LoopMode.all);
  }

  void setCurrentPlaying(int i) {
    currentPlaying = i;
    notifyListeners();
  }

  void setFullQuranAudioSource(int i) {
    setSurahNum(i + 1 > 114 ? 1 : i + 1);
    setCurrentPlaying(i);

    List<AudioSource> audiosource = [];

    for (int j = 0; j < _fullQuranAudio[i].length; j++) {
      audiosource.add(AudioSource.uri(
          Uri.parse(_fullQuranAudio[i].elementAt(j).toString()),
          tag: MediaItem(id: '$j', title: 'title')));
    }
    audiosource.add(AudioSource.uri(Uri.parse('Stop'), tag: 'Stop'));

    player.setAudioSource(ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audiosource,
    ));
  }

  Future<void> playAudio(int surahNumber, isLoadingFrom from) async {
    try {
      if (!player.playing) {
        if (from == isLoadingFrom.fromSingleSurah)
          isLoading = true;
        else
          fullQuranisLoading = true;
      }
      player.playing ? player.pause() : player.play();

      playIcon = player.playing ? EvaIcons.pauseCircle : EvaIcons.playCircle;
      if (player.playing) {
        if (from == isLoadingFrom.fromSingleSurah)
          isLoading = false;
        else
          fullQuranisLoading = false;
      }
      Timer.periodic(Duration(seconds: 1), (timer) {
        playIcon = player.playing ? EvaIcons.pauseCircle : EvaIcons.playCircle;
        notifyListeners();
      });
    } catch (e) {}
    notifyListeners();
  }

  void eraseSurah() {
    _ayahs = [];
    _surahAudio = [];
    if (player.audioSource != null) {
      player.audioSource!.sequence.clear();
    }
    if (player.sequence != null) {
      player.sequence!.clear();
    }
    isLoading = false;
    fullQuranisLoading = false;
    playIcon = EvaIcons.playCircle;
    notifyListeners();
  }

  void setReader(String reader, int surahNumber) async {
    readers.forEach((key, value) {
      if (key == reader) _reader = value.toString();
      notifyListeners();
    });

    await getSurahAudio(surahNumber);
    isLoading = false;

    notifyListeners();
  }

  void setFullQuranReader(String reader, BuildContext context) async {
    //setReader(reader, getSurahNumber);
    fullQuranisLoading = true;
    readers.forEach((key, value) {
      if (key == reader) _fullQuranReader = value.toString();
      notifyListeners();
    });

    await getFullQuranAudio(context);
    fullQuranisLoading = false;

    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setFullQuranIsLoading(bool value) {
    fullQuranisLoading = value;
    notifyListeners();
  }

  bool get getDonwloadLoading => donwloadLoading;
  bool get getFirstTime => firstTime;
  bool get getIsLoading => isLoading;
  bool get getFullQuranIsLoading => fullQuranisLoading;
  List<Ayah> get getAyahs => _ayahs;
  List<String> get getAyahAudio => _surahAudio;
  List get getFullQuranAudioList => _fullQuranAudio;
  String getReader() {
    String readerName = '';
    readers.forEach((key, value) {
      if (value == _reader) readerName = key.toString();
    });
    return readerName;
  }

  String getFullQuranReader() {
    String readerName = '';
    readers.forEach((key, value) {
      if (value == _fullQuranReader) readerName = key.toString();
    });
    return readerName;
  }

  int get getCurrentPlaying => currentPlaying;

  int getIsPlaying() {
    if (player.audioSource == null)
      return 0;
    else if (player.audioSource!.sequence.isEmpty) return 0;
    return 1;
  }
}
