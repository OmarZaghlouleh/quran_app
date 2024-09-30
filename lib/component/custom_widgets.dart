// ignore_for_file: avoid_print


import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:shimmer/shimmer.dart';

//White Progress Indicator
Widget whiteCircularIndicator() {
  return const CircularProgressIndicator(
    color: Colors.white,
    strokeWidth: 2,
  );
}

//Blue Progress Indicator
// ignore: non_constant_identifier_names
Widget BlueCircularIndicator() {
  return CircularProgressIndicator(
    color: mainColor,
    strokeWidth: 2,
  );
}

//Surah Card
Widget surahCard(BuildContext ctx, Surah surah) {
  final theme = Theme.of(ctx);
  return Card(
    color: Colors.white,
    elevation: 8,
    shadowColor: gradientColors[0],
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: gradientColors[1], width: 3)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: mainColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    surah.englishName.toString(),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: mainColor,
                      fontSize: 18,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: mainColor,
                          fontSize: 15,
                        ),
                        children: [
                          const TextSpan(
                            text: 'عدد الآيات: ',
                          ),
                          TextSpan(
                            text: surah.numberOfAyahs.toString(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: FittedBox(
                  child: Text(
                    surah.name.toString(),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class LoadingCard extends StatefulWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  _LoadingCardState createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: Colors.grey,
        highlightColor: gradientColors[1],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showbanner(BuildContext context, String message) {
  if (ScaffoldMessenger.maybeOf(context) != null) {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.end,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}

Widget myAppbar(String title, TextStyle? textStyle, [leading]) {
  return AppBar(
    iconTheme: IconThemeData(color: mainColor),
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: textStyle,
    ),
    actions: leading != null
        ? [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  leading.toString().contains('/')
                      ? leading
                          .toString()
                          .substring(leading.toString().indexOf('/') + 1)
                      : leading.toString(),
                  style: textStyle!.copyWith(fontSize: 15),
                ),
              ),
            )
          ]
        : [],
  );
}

Widget calendarListTile(String title, String value, ThemeData theme) {
  String finalValue = value.replaceFirst(
      value.substring(0, 2),
      ((int.tryParse(value.substring(0, 2))! - 12) > 0
              ? (int.tryParse(value.substring(0, 2))! - 12)
              : int.tryParse(value.substring(0, 2))!)
          .toString());

  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Center(
        child: ListTile(
          leading: Text(
            finalValue,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
          ),
          trailing: Text(
            title,
            textDirection: TextDirection.rtl,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    ),
  );
}

Widget customDivider() {
  return Divider(
    color: mainColor,
    thickness: 2,
    // endIndent: 30,
    indent: 50,
  );
}

Widget calendarRow(String title, String value, ThemeData theme) {
  return Column(
    children: [
      Text(value,
          textDirection: TextDirection.rtl,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.white,
          )),
      Text(
        title,
        textDirection: TextDirection.rtl,
        style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.normal),
      ),
    ],
  );
}

Widget roznamaLoadingCard() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.rtl,
    baseColor: Colors.grey,
    highlightColor: gradientColors[1],
    child: Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: gradientColors,
          )),
    ),
  );
}

Widget chooseReaderAlertDialog(BuildContext context) {
  final theme = Theme.of(context);
  return AlertDialog(
    backgroundColor: gradientColors[1],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      height: 170,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                ' : اختر القارئ ',
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                alignment: Alignment.centerRight,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                dropdownColor: gradientColors[1],
                onChanged: (String? value) {
                  Provider.of<AyahsViewModel>(context, listen: false)
                      .setFullQuranReader(value!, context);
                },
                items: readers.keys
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                    .toList(),
                value: Provider.of<AyahsViewModel>(context, listen: true)
                    .getReader(),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '.ملاحظة: يتم تحميل صوت القارئ للمرة الأولى فقط',
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: Colors.grey, fontSize: 15),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  Provider.of<AyahsViewModel>(context, listen: false)
                      .setFullQuranReader(
                          Provider.of<AyahsViewModel>(context, listen: false)
                              .getReader(),
                          context);
                },
                icon: const Icon(
                  EvaIcons.arrowCircleLeft,
                  color: Colors.white,
                  size: 50,
                )),
          )
        ],
      ),
    ),
  );
}

IconButton buildplayerIconButton(IconData iconData, Function toDo) {
  return IconButton(
      onPressed: () {
        toDo();
      },
      icon: Icon(
        iconData,
        color: gradientColors[1],
        size: 50,
      ));
}
