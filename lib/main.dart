
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:quran/views%20model/roznama_view_model.dart';
import 'package:quran/views%20model/surah_details_view_model.dart';
import 'package:quran/views/splash_screen.dart';

import 'component/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    preloadArtwork: true,
    androidNotificationChannelDescription: '',
    androidShowNotificationBadge: true,
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Holy Quran',
    androidNotificationOngoing: true,
    notificationColor: gradientColors[1],
  );

  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListOfSurahViewModel()),
        ChangeNotifierProvider(
          create: (context) => AyahsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoznamaViewModel(),
        ),
      ],
      child: MaterialApp(
        //theme

        theme: ThemeData(
            textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: mainColor,
            fontFamily: mainFont,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        )),
        debugShowCheckedModeBanner: false,

        home: const SplashScreen(),
      ),
    );
  }
}
