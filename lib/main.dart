import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quran/firebase_options.dart';
import 'package:quran/utils/app_route.dart';
import 'package:quran/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.getLightTheme(),
      routes: AppRoute.routes,
      initialRoute: AppRoute.layoutBuildScreen,
    );
  }
}
