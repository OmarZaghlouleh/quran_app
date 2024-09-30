class ListOfAyah {
  late List<dynamic> listofAyah;
  ListOfAyah(this.listofAyah);
  ListOfAyah.fromJson(Map jsonData) {
    listofAyah = jsonData['data']['ayahs'];
  }
}
