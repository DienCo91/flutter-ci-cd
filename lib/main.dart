import 'dart:async';

import 'package:batterylevel/cubit/simple_bloc_observer.dart';
import 'package:batterylevel/layout/app_state_container.dart';
import 'package:batterylevel/pages/home.dart';
import 'package:batterylevel/pages/profile.dart';
import 'package:batterylevel/pages/setting.dart';
import 'package:batterylevel/todos/repository/todos_repository.dart';
import 'package:batterylevel/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(MobileAds.instance.initialize());

  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(AppStateContainer(child: const MyApp()));
}

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple, brightness: Brightness.dark),

        textTheme: TextTheme(displayLarge: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        final uri = Uri.parse(name);

        if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'profile') {
          String? id;
          if (uri.pathSegments.length > 1) {
            id = uri.pathSegments[1];
          }
          return MaterialPageRoute(builder: (context) => Profile(userId: id));
        }
        if (name == '/todo') {
          return MaterialPageRoute(
            builder: (context) {
              return RepositoryProvider(create: (context) => TodosRepository(), child: const TodosPage());
            },
          );
        }

        if (name == '/') {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
        if (name == '/setting') {
          return MaterialPageRoute(builder: (context) => const SettingPage());
        }

        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
