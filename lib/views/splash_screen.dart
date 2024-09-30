import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:quran/views%20model/surah_details_view_model.dart';
import 'package:quran/views/landing_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    navigte();
  }

  void navigte() async {
    await Provider.of<ListOfSurahViewModel>(context, listen: false)
        .getSurahDetails(context);
    await Provider.of<AyahsViewModel>(context, listen: false)
        .getAlFatehaAudioSource();
    //await Provider.of<RoznamaViewModel>(context, listen: false).getRoznama();
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const LandingScreen(),
            type: PageTransitionType.topToBottom));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: gradientColors[1],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: const AssetImage("assets/images/quran.png"),
              filterQuality: FilterQuality.high,
              width: mq.size.width * 0.8,
              height: mq.size.height * 0.3,
            ),
          ),
          whiteCircularIndicator()
        ],
      ),
    );
  }
}
