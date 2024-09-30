import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quran/component/custom_widgets.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  PackageInfo packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    var data = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('', Theme.of(context).textTheme.bodyMedium)
          as PreferredSizeWidget,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Holy Quran\nالقرآن الكريم',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Text(
              'App Version\n${packageInfo.version}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15, fontFamily: ''),
              textAlign: TextAlign.center,
            ),
            Text(
              '\nLicenses\n- https://www.freepik.com/vectors/business\nBusiness vector created by macrovector - www.freepik.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15, fontFamily: ''),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
