import 'package:batterylevel/core/network/dio_client.dart';
import 'package:batterylevel/counter/view/counter_page.dart';
import 'package:batterylevel/features/tutorial/presentation/screens/todo_screen.dart';
import 'package:batterylevel/features/tutorial/tutorial.dart';
import 'package:batterylevel/genui_page/genui_page.dart';
import 'package:batterylevel/pages/home.dart';
import 'package:batterylevel/pages/profile.dart';
import 'package:batterylevel/pages/setting.dart';
import 'package:batterylevel/pages/ui_mcp_screen.dart';
import 'package:batterylevel/price_list/price_list.dart';
import 'package:batterylevel/purchase/views/purchase_page.dart';
import 'package:batterylevel/scroll_advance/sliver_app_bar.dart';
import 'package:batterylevel/sql_lite/sql_lite_page.dart';
import 'package:batterylevel/timer/views/timer_page.dart';
import 'package:batterylevel/todos/repository/todos_repository.dart';
import 'package:batterylevel/todos/view/todos_page.dart';
import 'package:batterylevel/weather/view/weather_page.dart';
import 'package:batterylevel/web_socket_binance/binance_trading/views/binance_trading.dart';
import 'package:batterylevel/web_socket_binance/web_socket_binance.dart';
import 'package:batterylevel/web_socket_binance/web_socket_binance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:weather_repository/weather_repository.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/');
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  },
  routes: [
    GoRoute(path: '/setting', builder: (context, state) => const SettingPage()),
    GoRoute(
      path: '/profile/:id',
      builder: (context, state) => Profile(userId: state.pathParameters['id']),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const Profile()),
    GoRoute(
      path: '/todo',
      builder: (context, state) => RepositoryProvider(
        create: (context) => TodosRepository(dio: DioClient().dio),
        child: const TodosPage(),
      ),
    ),
    GoRoute(path: '/counter', builder: (context, state) => const CounterPage()),
    GoRoute(path: '/timer', builder: (context, state) => const TimerPage()),
    GoRoute(
      path: '/weather',
      builder: (context, state) => RepositoryProvider(
        create: (context) => WeatherRepository(
          openMeteoApiClient: OpenMeteoApiClient(dio: DioClient().dio),
        ),
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
    GoRoute(path: '/uimcp', builder: (context, state) => const UiMcpScreen()),
    GoRoute(path: '/joke', builder: (context, state) => const JokeScreen()),
    GoRoute(
      path: '/counter_riverpod_screen',
      builder: (context, state) => const CounterScreen(),
    ),
    GoRoute(
      path: '/todo_riverpod_screen',
      builder: (context, state) => const TodoScreen(),
    ),

    GoRoute(
      path: '/binance_trading',
      redirect: (context, state) {
        final symbol = state.extra as String?;
        if (symbol == null || symbol.isEmpty) {
          return '/';
        }
        return null;
      },
      builder: (context, state) {
        final symbol = state.extra as String;
        return BinanceTrading(symbol: symbol);
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navigationShell.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.price_change),
                label: 'Price list',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'Exchange Info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Riverpod',
              ),
            ],
            onTap: (int index) {
              return navigationShell.goBranch(index);
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (_, _) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/price_list',
              builder: (context, state) {
                return PriceListPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/binance_exchange_info',
              builder: (context, state) {
                return GetBuilder<WebSocketBinanceController>(
                  init: WebSocketBinanceController(),
                  builder: (controller) {
                    return const WebSocketBinance();
                  },
                );
              },
              routes: [
                GoRoute(
                  path: 'binance_trading',
                  redirect: (context, state) {
                    final symbol = state.extra as String?;
                    if (symbol == null || symbol.isEmpty) {
                      return '/';
                    }
                    return null;
                  },
                  builder: (context, state) {
                    final symbol = state.extra as String;
                    return BinanceTrading(symbol: symbol);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tutorial_riverpod',
              name: 'tutorial_riverpod',
              builder: (_, _) => const TutorialScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
