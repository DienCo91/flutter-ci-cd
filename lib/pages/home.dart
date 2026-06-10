import 'dart:async';

import 'package:batterylevel/counter/view/counter_page.dart';
import 'package:batterylevel/helper/ads_helper.dart';
import 'package:batterylevel/interacting/use_pigeon.dart';
import 'package:batterylevel/pages/profile.dart';
import 'package:batterylevel/scroll_advance/sliver_app_bar.dart';
import 'package:batterylevel/sql_lite/sql_lite_page.dart';
import 'package:batterylevel/timer/views/timer_page.dart';
import 'package:batterylevel/weather/view/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weather_repository/weather_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('sample.flutter.dev/battery');
  String _text = 'Unknown battery level.';
  Timer? _timer;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    _bannerAd?.dispose();
  }

  void _loadAd() {
    final bannerAd = AdsHelper.loadBannerAd(
      setState: (ad) => setState(() => _bannerAd = ad as BannerAd),
      mounted: mounted,
    );

    // Start loading.
    bannerAd.load();
  }

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _text = 'Battery level at $result % .';
      });
    } catch (e) {
      setState(() {
        _text = e.toString();
      });
    }
  }

  Future<void> getStatusRam() async {
    try {
      Map<String, num> result = await getRamStatus();
      setState(() {
        _text =
            'Ram App Used: ${result['ramUsed']} MB \n ramTotal: ${result['ramTotal']} MB \n ramFree: ${result['ramFree']} MB \n pinStatus: ${result['pinStatus']}% \n tempStatus: ${result['tempStatus']}';
      });
    } catch (e) {
      setState(() {
        _text = e.toString();
      });
    }
  }

  Future<void> getNetworkStatus() async {
    try {
      Map<String, String> result = await getNetworkInfo();
      setState(() {
        _text =
            'name: ${result['name']} \n speed: ${result['speed']} \n carrierName: ${result['carrierName']} \n connectionType: ${result['connectionType']}';
      });
    } catch (e) {
      setState(() {
        _text = e.toString();
      });
    }
  }

  void goToProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
  }

  void goToDos() {
    Navigator.pushNamed(context, '/todo');
  }

  void goToCounter() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterPage()));
  }

  void goToTimer() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TimerPage()));
  }

  void goToSearchWeatherByName() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepositoryProvider(create: (context) => WeatherRepository(), child: const WeatherPage()),
      ),
    );
  }

  void goToSliverAppBar() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SliverAppBarExample()));
  }

  void goToSqlLite() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SqlLitePage()));
  }

  @override
  Widget build(BuildContext context) {
    print("===AppFlavor: $appFlavor");
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Home")),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (appFlavor == 'production')
                        Center(child: Text("Production"))
                      else if (appFlavor == 'staging')
                        Center(child: Text("Staging")),

                      Text(_text),
                      ElevatedButton(onPressed: goToDos, child: Text('Go to Todos')),
                      ElevatedButton(onPressed: goToTimer, child: Text('Go to Timer')),
                      ElevatedButton(onPressed: onClick, child: Text("Get Text Pigeon")),
                      ElevatedButton(onPressed: goToSqlLite, child: Text('Go to sqlite')),
                      ElevatedButton(onPressed: goToProfile, child: Text('Go to Profile')),
                      ElevatedButton(onPressed: goToCounter, child: Text('Go to Counter')),
                      ElevatedButton(onPressed: getStatusRam, child: Text("Get Status Ram")),
                      ElevatedButton(onPressed: getNetworkStatus, child: Text("Get Network Info")),
                      ElevatedButton(onPressed: _getBatteryLevel, child: Text("Get Battery Level")),
                      ElevatedButton(onPressed: goToSliverAppBar, child: Text('Go to sliver app bar')),
                      ElevatedButton(onPressed: goToSearchWeatherByName, child: Text('Go to Search Weather')),
                      ElevatedButton(onPressed: goToSearchWeatherByName, child: Text('Go to Search Weather')),
                      ElevatedButton(onPressed: goToSearchWeatherByName, child: Text('Go to Search Weather')),
                    ],
                  ),
                ),
              ),
            ),

            if (_bannerAd != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
