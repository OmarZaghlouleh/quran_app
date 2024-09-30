// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/views%20model/full_ayah_view_model.dart';
import 'package:quran/views%20model/surah_details_view_model.dart';

class FullQuranAudioView extends StatefulWidget {
  const FullQuranAudioView({Key? key}) : super(key: key);

  @override
  _FullQuranAudioViewState createState() => _FullQuranAudioViewState();
}

class _FullQuranAudioViewState extends State<FullQuranAudioView> {
  @override
  Widget build(BuildContext context) {
    final providerFunction =
        Provider.of<AyahsViewModel>(context, listen: false);
    final providerData = Provider.of<AyahsViewModel>(context, listen: true);
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: myAppbar('', theme.textTheme.bodyMedium) as PreferredSizeWidget,
      bottomNavigationBar: (providerData.getFullQuranAudioList.isEmpty &&
              !providerData.getDonwloadLoading &&
              !providerData.getFullQuranIsLoading)
          ? chooseReaderAlertDialog(context)
          : providerData.getDonwloadLoading
              ? null
              : SafeArea(
                  child: Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildplayerIconButton(Icons.arrow_back,
                            () => providerFunction.setFullQuranAudioSource(0)),
                        buildplayerIconButton(EvaIcons.skipBackOutline, () {
                          providerData.currentPlaying - 1 >= 0
                              ? providerFunction.setFullQuranAudioSource(
                                  providerData.currentPlaying - 1)
                              : providerFunction.setFullQuranAudioSource(113);
                        }),
                        buildplayerIconButton(providerData.playIcon, () {
                          if (player.audioSource == null)
                            providerFunction.setFullQuranAudioSource(
                                providerData.getCurrentPlaying);
                          providerFunction.playAudio(
                              providerData.getSurahNumber,
                              isLoadingFrom.fromFullQuran);
                        }),
                        buildplayerIconButton(
                            EvaIcons.skipForwardOutline,
                            () => providerData.currentPlaying + 1 < 114
                                ? providerFunction.setFullQuranAudioSource(
                                    providerData.currentPlaying + 1)
                                : providerFunction.setFullQuranAudioSource(0)),
                        buildplayerIconButton(
                            Icons.arrow_forward,
                            () =>
                                providerFunction.setFullQuranAudioSource(113)),
                      ],
                    ),
                  ),
                ),
      body: SafeArea(
        child: Center(
          child: (providerData.getFullQuranAudioList.isEmpty &&
                  !providerData.getDonwloadLoading &&
                  !providerData.getFullQuranIsLoading)
              ? chooseReaderAlertDialog(context)
              : providerData.getDonwloadLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  ..جاري التحميل\n  ${providerData.getCurrentDownloading}/114',
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(child: BlueCircularIndicator()),
                      ],
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  Provider.of<ListOfSurahViewModel>(context,
                                          listen: true)
                                      .getListofSurah[
                                          providerData.getSurahNumber - 1]
                                      .name
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                            ),
                            width: mq.size.width * 0.98,
                            height: mq.size.height * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradientColors,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: gradientColors[1],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton<String>(
                                alignment: Alignment.centerRight,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                dropdownColor: gradientColors[1],
                                onChanged: (String? value) async {
                                  providerFunction.setFullQuranReader(
                                      value!, context);
                                  providerFunction.eraseFullQuran();
                                  await providerFunction
                                      .getFullQuranAudio(context);
                                  providerFunction.setFullQuranAudioSource(
                                      providerData.getSurahNumber - 1);
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
                                value: providerData.getFullQuranReader(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '.ملاحظة: سوف يتم تحميل صوت القارئ في حال لم يتم تحميله من قبل',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            '${providerData.getSurahNumber}/114',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: gradientColors[1]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
