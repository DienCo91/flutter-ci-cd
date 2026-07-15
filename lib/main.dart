import 'dart:async';

import 'package:batterylevel/cubit/simple_bloc_observer.dart';
import 'package:batterylevel/layout/app_state_container.dart';
import 'package:batterylevel/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  unawaited(MobileAds.instance.initialize());

  // Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(AppStateContainer(child: const MyApp()));
}

@Preview(name: 'My Sample Text')
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppOpenAd? _appOpenAd;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   handleAppOpenAd();
    // });
  }

  @override
  void dispose() {
    _appOpenAd?.dispose();
    super.dispose();
  }

  // void handleAppOpenAd() {
  //   AdsHelper.loadAppOpenAd(
  //     onLoaded: (ad) {
  //       if (!mounted) {
  //         ad.dispose();
  //         return;
  //       }
  //       _appOpenAd = ad;
  //       _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdDismissedFullScreenContent: (ad) {
  //           ad.dispose();
  //           _appOpenAd = null;
  //         },
  //         onAdFailedToShowFullScreenContent: (ad, error) {
  //           ad.dispose();
  //           _appOpenAd = null;
  //           debugPrint('AppOpenAd failed to show: $error');
  //         },
  //       );
  //       _appOpenAd!.show();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple, brightness: Brightness.dark),
        textTheme: TextTheme(displayLarge: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
