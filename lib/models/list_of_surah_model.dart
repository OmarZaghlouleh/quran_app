class ListOfSurah {
  late List<dynamic> listOfSurah;
  ListOfSurah(this.listOfSurah);
  ListOfSurah.fromJson(Map jsonData) {
    listOfSurah = jsonData['data'];
  }
}
