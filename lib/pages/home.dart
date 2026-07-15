import 'dart:async';

import 'package:batterylevel/helper/ads_helper.dart';
import 'package:batterylevel/interacting/use_pigeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
    context.push('/profile');
  }

  void goToDos() {
    context.push('/todo');
  }

  void goToCounter() {
    context.push('/counter');
  }

  void goToTimer() {
    context.push('/timer');
  }

  void goToSearchWeatherByName() {
    context.push('/weather');
  }

  void goToSliverAppBar() {
    context.push('/sliver');
  }

  void goToSqlLite() {
    context.push('/sqlite');
  }

  void goToPurchase() {
    context.push('/purchase');
  }

  void gotoGenUiPage() {
    context.push('/genui');
  }

  void goToUiMcpScreen() {
    context.push('/uimcp');
  }

  void gotoWebSocket() {
    context.push('/binance_exchange_info');
  }

  void gotoPriceList() {
    context.push('/price_list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Home")),
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisAlignment: .center,
                    mainAxisSize: .min,
                    textDirection: .ltr,
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
                      ElevatedButton(onPressed: goToPurchase, child: Text('Go to Purchase Consumable')),
                      ElevatedButton(onPressed: getStatusRam, child: Text("Get Status Ram")),
                      ElevatedButton(onPressed: getNetworkStatus, child: Text("Get Network Info")),
                      ElevatedButton(onPressed: _getBatteryLevel, child: Text("Get Battery Level")),
                      ElevatedButton(onPressed: goToSliverAppBar, child: Text('Go to sliver app bar')),
                      ElevatedButton(onPressed: goToSearchWeatherByName, child: Text('Go to Search Weather')),
                      ElevatedButton(onPressed: gotoGenUiPage, child: Text('GenUI Page')),
                      ElevatedButton(onPressed: goToUiMcpScreen, child: Text('UI MCP Screen')),
                      ElevatedButton(onPressed: gotoWebSocket, child: Text('Binance Exchange Info')),
                      ElevatedButton(onPressed: gotoPriceList, child: Text('Go to Price List')),
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
