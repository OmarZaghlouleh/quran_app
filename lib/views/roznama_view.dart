// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/component/constants.dart';
import 'package:quran/component/custom_widgets.dart';
import 'package:quran/views%20model/roznama_view_model.dart';

class HijriCalendarView extends StatefulWidget {
  const HijriCalendarView({Key? key}) : super(key: key);

  @override
  _HijriCalendarViewState createState() => _HijriCalendarViewState();
}

class _HijriCalendarViewState extends State<HijriCalendarView> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    // if (Provider.of<RoznamaViewModel>(context, listen: false)
    //         .getCalendar
    //         .gregorianDate ==
    //     '')
    Provider.of<RoznamaViewModel>(context, listen: false).reset();
    await Provider.of<RoznamaViewModel>(context, listen: false).getRoznama();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = Provider.of<RoznamaViewModel>(context, listen: true);

    return Scaffold(
        appBar: myAppbar('روزناما', theme.textTheme.bodyMedium,
            data.getCalendar.timezone) as PreferredSizeWidget,
        body: data.isInitilized
            ? (data.getCalendar.hijriDate.isEmpty
                ? Center(
                    child: Text(
                    "حدث خطأ ما",
                    style: theme.textTheme.bodyMedium,
                  ))
                : Column(
                    children: [
                      if (data.isLoading)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlueCircularIndicator(),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(10)),
                              gradient: LinearGradient(colors: gradientColors)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(days[DateTime.now().weekday - 1],
                                  textDirection: TextDirection.rtl,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  calendarRow(
                                      gregorianMonth[DateTime.now().month - 1],
                                      data.getCalendar.gregorianDate,
                                      theme),
                                  calendarRow(
                                      hijriMonth.entries
                                          .firstWhere((element) =>
                                              element.key.toString() ==
                                              data.getCalendar.hijriDate
                                                  .substring(3, 5)
                                                  .toString())
                                          .value,
                                      data.getCalendar.hijriDate,
                                      theme)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          color: mainColor,
                          onRefresh: () async {
                            await Provider.of<RoznamaViewModel>(context,
                                    listen: false)
                                .getRoznama();
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //Fajr
                                calendarListTile(
                                    'الفجر', data.getCalendar.fajr, theme),
                                customDivider(),
                                //Sunrise
                                if (data.getCalendar.sunrise != '-')
                                  calendarListTile('شروق الشمس',
                                      data.getCalendar.sunrise, theme),
                                if (data.getCalendar.sunrise != '-')
                                  customDivider(),
                                //Duhr
                                calendarListTile(
                                    'الظهر', data.getCalendar.duhr, theme),
                                customDivider(),
                                //Asr
                                calendarListTile(
                                    'العصر', data.getCalendar.asr, theme),
                                customDivider(),
                                //Mughrib
                                calendarListTile(
                                    'المغرب', data.getCalendar.maghrib, theme),
                                customDivider(),
                                //Isha
                                calendarListTile(
                                    'العشاء', data.getCalendar.isha, theme),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: roznamaLoadingCard(),
                    )));
  }
}
