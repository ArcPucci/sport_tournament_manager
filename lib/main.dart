import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/screens/screens.dart';
import 'package:sport_tournament_manager/services/services.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final sqlService = SqlService();
      await sqlService.init();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        ScreenUtilInit(
          designSize: Size(390, 844),
          builder: (context, child) => MyApp(sqlService: sqlService),
        ),
      );
    },
    (error, stack) {
      print(error);
      print(stack);
    },
  );
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool opaque = true,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    opaque: opaque,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.sqlService});

  final SqlService sqlService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            NavigationScreen(path: state.fullPath ?? '/', child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const MainScreen(),
            routes: [
              GoRoute(
                path: 'create',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const CreateScreen(),
                ),
              ),
              GoRoute(
                path: 'edit',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const CreateScreen(isEdit: true),
                ),
              ),
              GoRoute(
                path: 'tournaments',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const TournamentsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => TournamentsService(widget.sqlService.database),
        ),
        ChangeNotifierProvider(
          create: (context) => TournamentsProvider(
            tournamentsService: Provider.of(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: _router,
      ),
    );
  }
}
