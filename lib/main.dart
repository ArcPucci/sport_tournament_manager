import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/screens/screens.dart';
import 'package:sport_tournament_manager/services/services.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final sqlService = SqlService();
      await sqlService.init();

      final preferences = await SharedPreferences.getInstance();
      final preferencesProvider = PreferencesProvider(preferences);

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        ScreenUtilInit(
          designSize: Size(390, 844),
          builder: (context, child) => MyApp(
            sqlService: sqlService,
            preferencesProvider: preferencesProvider,
          ),
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
  const MyApp({
    super.key,
    required this.sqlService,
    required this.preferencesProvider,
  });

  final SqlService sqlService;
  final PreferencesProvider preferencesProvider;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: widget.preferencesProvider.getFirstInit()
          ? '/welcome'
          : '/',
      routes: [
        GoRoute(
          path: '/welcome',
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnboardingScreen(),
        ),
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
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const CreateScreen(),
                      ),
                ),
                GoRoute(
                  path: 'edit',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const CreateScreen(isEdit: true),
                      ),
                ),
                GoRoute(
                  path: 'tournaments',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const TournamentsScreen(),
                      ),
                ),
                GoRoute(
                  path: 'tournament',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const TournamentScreen(),
                      ),
                ),
                GoRoute(
                  path: 'profile',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const MyAccountScreen(),
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.preferencesProvider),
        Provider(
          create: (context) => TournamentsService(widget.sqlService.database),
        ),
        Provider(
          create: (context) => MatchesService(widget.sqlService.database),
        ),
        ChangeNotifierProvider(
          create: (context) => TournamentsProvider(
            tournamentsService: Provider.of(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ConfigProvider(widget.preferencesProvider),
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
