import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nov_movie_app/router/app.router.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Nov Movie App',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade700,
      ),

      // Router Config
      routeInformationParser: _appRouter.router.routeInformationParser,
      routeInformationProvider: _appRouter.router.routeInformationProvider,
      routerDelegate: _appRouter.router.routerDelegate,
      backButtonDispatcher: _appRouter.router.backButtonDispatcher,
    );
  }
}
