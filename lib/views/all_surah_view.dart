// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:quran/views%20model/surah_details_view_model.dart';
import 'package:quran/views/surah_view.dart';

class AllSurahView extends StatefulWidget {
  const AllSurahView({Key? key}) : super(key: key);

  @override
  State<AllSurahView> createState() => _AllSurahViewState();
}

class _AllSurahViewState extends State<AllSurahView> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<ListOfSurahViewModel>(context, listen: true);

    return Scaffold(
      appBar: myAppbar('السُوَر', theme.textTheme.bodyMedium)
          as PreferredSizeWidget,
      bottomNavigationBar: Provider.of<AyahsViewModel>(context, listen: true)
                  .getIsPlaying() ==
              1
          ? Container(
              color: gradientColors[1],
              height: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              alignment: Alignment.centerRight,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              dropdownColor: gradientColors[1],
                              onChanged: (String? value) {
                                Provider.of<AyahsViewModel>(context,
                                        listen: false)
                                    .setReader(
                                        value!,
                                        Provider.of<AyahsViewModel>(context,
                                                listen: false)
                                            .getSurahNumber);
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
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 20),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: Provider.of<AyahsViewModel>(context,
                                      listen: true)
                                  .getReader(),
                            ),
                          ),
                          Text(
                            Provider.of<ListOfSurahViewModel>(context,
                                    listen: true)
                                .getListofSurah[Provider.of<AyahsViewModel>(
                                            context,
                                            listen: true)
                                        .getSurahNumber -
                                    1]
                                .name,
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Provider.of<AyahsViewModel>(context, listen: true)
                              .isLoading
                          ? whiteCircularIndicator()
                          : Icon(
                              Provider.of<AyahsViewModel>(context, listen: true)
                                  .playIcon,
                              color: Colors.white,
                              size: 40,
                            ),
                      onPressed: () {
                        Provider.of<AyahsViewModel>(context, listen: false)
                            .playAudio(
                                Provider.of<AyahsViewModel>(context,
                                        listen: false)
                                    .getSurahNumber,
                                isLoadingFrom.fromSingleSurah);
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => provider.getListofSurah.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                child: LoadingCard(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 2, right: 2, top: 1),
                child: GestureDetector(
                    onTap: () {
                      bool flag = true;
                      /////
                      int currentIndex =
                          Provider.of<AyahsViewModel>(context, listen: false)
                                  .getSurahNumber -
                              1;

                      if (currentIndex != index) {
                        //
                        flag = false;
                        Provider.of<AyahsViewModel>(context, listen: false)
                            .eraseSurah();
                        player.pause();
                        Provider.of<AyahsViewModel>(context, listen: false)
                            .setIsLoading(true);
                        //
                      }
                      ////////
                      ///
                      Provider.of<AyahsViewModel>(context, listen: false)
                          .setCurrentPlaying(
                              provider.getListofSurah[index].number - 1);
                      Provider.of<AyahsViewModel>(context, listen: false)
                          .setSurahNum(provider.getListofSurah[index].number);

                      Navigator.push(
                          context,
                          PageTransition(
                              child: SurahView(
                                  provider.getListofSurah[index].number, flag),
                              type: PageTransitionType.rightToLeftWithFade));
                    },
                    child: surahCard(context, provider.getListofSurah[index])),
              ),
        itemCount: provider.getListofSurah.isEmpty
            ? 10
            : provider.getListofSurah.length,
      ),
    );
  }
}
