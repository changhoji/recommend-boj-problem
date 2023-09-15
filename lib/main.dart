import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/firebase_options.dart';
import 'package:whattosolve/providers/controllers.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/providers/tags.dart';
import 'package:whattosolve/screens/bookmark_screen.dart';
import 'package:whattosolve/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'bookmark',
          builder: (context, state) => const BookmarkScreen(),
        )
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchFilter('1번 필터')),
        ChangeNotifierProvider(create: (_) => Tags()),
        ChangeNotifierProvider(create: (_) => Controllers()),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
