import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/views/all_surah_view.dart';
import 'package:quran/views/full_quran_audio_view.dart';
import 'package:quran/views/roznama_view.dart';

Color mainColor = const Color(0xff0f417a);
String mainFont = 'AlQuranAli-L3A83';
String ayahFont = 'Quran karim 114';

List<Color> gradientColors = const [
  Color(0xFF4E0B4D),
  Color(0xFF095A5A),
];
List<Color> cardGradientColors = const [
  Color(0xFF82D8D8),
  Color(0xFF095A5A),
];
List<String> days = [
  "الاثنين",
  "الثلاثاء",
  "الأربعاء",
  "الخميس",
  "الجمعة",
  "السبت",
  "الأحد"
];

Map<String, String> hijriMonth = {
  "01": "محرم",
  "02": "صفر",
  "03": "ربيع الأول",
  "04": "ربيع الآخر",
  "05": "جمادى الأولى",
  "06": "جمادى الآخرة",
  "07": "رجب",
  "08": "شعبان",
  "09": "رمضان",
  "10": "شوال",
  "11": "ذو القعدة",
  "12": "ذو الحجة",
};
List<String> gregorianMonth = [
  "كانون الثاني",
  "شباط",
  "آذار",
  "نيسان",
  "آيار",
  "حزيران",
  "تموز",
  "آب",
  "أيلول",
  "تشرين الأول",
  "تشرين الثاني",
  "كانون الأول",
];

enum isLoadingFrom { fromFullQuran, fromSingleSurah }

ScrollController listener = ScrollController();
Map<String, dynamic> gridViewTitles = {
  'أوقات الصلاة': const HijriCalendarView(),
  'القرآن الكريم': const AllSurahView(),
  'الاستماع للقرآن الكريم كاملاً': const FullQuranAudioView(),
};
final player = AudioPlayer();
Map<String, String> readers = {
  "عبد الباسط عبد الصمد المرتل": "ar.abdulbasitmurattal",
  "عبد الله بصفر": "ar.abdullahbasfar",
  "عبدالرحمن السديس": "ar.abdurrahmaansudais",
  "عبدالباسط عبدالصمد": "ar.abdulsamad",
  "أبو بكر الشاطري": "ar.shaatree",
  "أحمد بن علي العجمي": "ar.ahmedajamy",
  "مشاري العفاسي": "ar.alafasy",
  "هاني الرفاعي": "ar.hanirifai",
  "محمود خليل الحصري": "ar.husary",
  "محمود خليل الحصري (المجود)": "ar.husarymujawwad",
  "علي بن عبدالرحمن الحذيفي": "ar.hudhaify",
  "إبراهيم الأخضر": "ar.ibrahimakhbar",
  "ماهر المعيقلي": "ar.mahermuaiqly",
  "محمد صديق المنشاوي": "ar.minshawi",
  "محمد صديق المنشاوي (المجود)": "ar.minshawimujawwad",
  "محمد أيوب": "ar.muhammadayyoub",
  "محمد جبريل": "ar.muhammadjibreel",
  "سعود الشريم": "ar.saoodshuraym",
  "أيمن سويد": "ar.aymanswoaid",
};
