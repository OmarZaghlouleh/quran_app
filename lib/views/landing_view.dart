import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:quran/component/constants.dart';
import 'package:quran/views/info_view.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: InfoView(),
                        type: PageTransitionType.rightToLeft));
              },
              icon: Icon(
                Icons.info_outline,
                color: mainColor,
              ))
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: gridViewTitles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: mq.size.width > 500 ? 2 : 1,
              childAspectRatio: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: gridViewTitles.values.toList()[index],
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                        width: mq.size.width,
                        fit: BoxFit.fill,
                        image: AssetImage(gridViewTitles.keys
                                    .toList()[index]
                                    .toString() ==
                                'القرآن الكريم'
                            ? "assets/images/quran_background.jpg"
                            : (gridViewTitles.keys.toList()[index].toString() ==
                                    'أوقات الصلاة'
                                ? "assets/images/roznama.jpg"
                                : "assets/images/listen_quran.jpg"))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            gridViewTitles.keys.toList()[index].toString(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
