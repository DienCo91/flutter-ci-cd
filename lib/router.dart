import 'package:batterylevel/counter/view/counter_page.dart';
import 'package:batterylevel/genui_page/genui_page.dart';
import 'package:batterylevel/pages/home.dart';
import 'package:batterylevel/pages/profile.dart';
import 'package:batterylevel/pages/setting.dart';
import 'package:batterylevel/purchase/views/purchase_page.dart';
import 'package:batterylevel/scroll_advance/sliver_app_bar.dart';
import 'package:batterylevel/sql_lite/sql_lite_page.dart';
import 'package:batterylevel/timer/views/timer_page.dart';
import 'package:batterylevel/todos/repository/todos_repository.dart';
import 'package:batterylevel/todos/view/todos_page.dart';
import 'package:batterylevel/weather/view/weather_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_repository/weather_repository.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/setting', builder: (context, state) => const SettingPage()),
    GoRoute(
      path: '/profile/:id',
      builder: (context, state) => Profile(userId: state.pathParameters['id']),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const Profile()),
    GoRoute(
      path: '/todo',
      builder: (context, state) => RepositoryProvider(
        create: (context) => TodosRepository(),
        child: const TodosPage(),
      ),
    ),
    GoRoute(path: '/counter', builder: (context, state) => const CounterPage()),
    GoRoute(path: '/timer', builder: (context, state) => const TimerPage()),
    GoRoute(
      path: '/weather',
      builder: (context, state) => RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: const WeatherPage(),
      ),
    ),
    GoRoute(
      path: '/sliver',
      builder: (context, state) => const SliverAppBarExample(),
    ),
    GoRoute(path: '/sqlite', builder: (context, state) => const SqlLitePage()),
    GoRoute(
      path: '/purchase',
      builder: (context, state) => const PurchasePage(),
    ),
    GoRoute(path: '/genui', builder: (context, state) => const GenUiPage()),
  ],
);
