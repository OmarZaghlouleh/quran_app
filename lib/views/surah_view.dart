// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:quran/views%20model/surah_details_view_model.dart';
import 'package:shimmer/shimmer.dart';

class SurahView extends StatefulWidget {
  SurahView(this.surahNumber, this.dontUpdate, {Key? key}) : super(key: key);
  int surahNumber;
  bool dontUpdate;

  @override
  _SurahViewState createState() => _SurahViewState();
}

class _SurahViewState extends State<SurahView> {
  final ScrollController _scrollController = ScrollController();
  @override
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    getData();
  }

  void getData() async {
    await Provider.of<AyahsViewModel>(context, listen: false)
        .getSurah(widget.surahNumber);
    if (widget.dontUpdate == false)
      await Provider.of<AyahsViewModel>(context, listen: false)
          .getSurahAudio(widget.surahNumber);
  }

  @override
  Widget build(BuildContext context) {
    final ayahs = Provider.of<AyahsViewModel>(context, listen: true).getAyahs;
    final surah = Provider.of<ListOfSurahViewModel>(context, listen: true)
        .getListofSurah[widget.surahNumber - 1];
    final theme = Theme.of(context);
    final data = Provider.of<AyahsViewModel>(context, listen: true);

    return Scaffold(
      appBar: myAppbar(
        surah.name,
        theme.textTheme.bodyMedium,
      ) as PreferredSizeWidget,
      floatingActionButton: (ayahs.isEmpty && data.showUpDownFloating)
          ? null
          : Container(
              width: 40,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: gradientColors[1],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        _scrollController.jumpTo(0);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_up_rounded,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      icon: const Icon(Icons.arrow_circle_down_rounded,
                          color: Colors.white))
                ],
              ),
            ),
      bottomNavigationBar: (player.audioSource == null)
          ? Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: gradientColors[1],
              direction: ShimmerDirection.rtl,
              child: Container(
                height: 80,
                color: Colors.grey,
              ),
            )
          : Container(
              color: gradientColors[1],
              height: 80,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: DropdownButton<String>(
                        alignment: Alignment.centerRight,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        dropdownColor: gradientColors[1],
                        onChanged: (String? value) {
                          Provider.of<AyahsViewModel>(context, listen: false)
                              .setReader(value!, widget.surahNumber);
                        },
                        items: readers.keys
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.rtl,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )
                            .toList(),
                        value: data.getReader(),
                      ),
                    ),
                    IconButton(
                      icon: data.isLoading
                          ? whiteCircularIndicator()
                          : Icon(
                              data.playIcon,
                              color: Colors.white,
                              size: 40,
                            ),
                      onPressed: () {
                        Provider.of<AyahsViewModel>(context, listen: false)
                            .playAudio(widget.surahNumber,
                                isLoadingFrom.fromSingleSurah);
                      },
                    ),
                  ],
                ),
              ),
            ),
      body: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: ayahs.isEmpty ? 20 : ayahs.length,
        itemBuilder: (context, index) => ayahs.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: gradientColors[1],
                  direction: ShimmerDirection.rtl,
                  child: Container(
                    width: 40,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          backgroundColor: gradientColors[1],
                          radius: 15,
                          child: Center(
                            child: Text(
                              ayahs[index].numberInSurah.toString(),
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              ayahs[index].text,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(fontSize: 20, color: Colors.black,fontFamily: ayahFont),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: index==ayahs.length-1?120:0),
                      child: Divider(
                        color: gradientColors[1],
                        indent: 20,
                        endIndent: 20,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
