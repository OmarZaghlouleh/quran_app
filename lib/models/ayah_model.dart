class Ayah {
  late String text;
  late int numberInSurah;

  Ayah(this.text, this.numberInSurah);
  Ayah.fromJson(Map jsonData) {
    text = jsonData['text'];
    numberInSurah = jsonData['numberInSurah'];
  }
}
