class Surah {
  late String name;
  late String englishName;
  late int numberOfAyahs;
  late int number;
  Surah(this.name, this.englishName, this.numberOfAyahs, this.number);
  Surah.fromJson(Map jsonData) {
    name = jsonData['name'];
    englishName = jsonData['englishName'];
    numberOfAyahs = jsonData['numberOfAyahs'];
    number = jsonData['number'];
  }
}
