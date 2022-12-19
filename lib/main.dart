import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'theme.dart' as theme;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "get-ded-4afa4",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Animators Club",
    initialRoute: '/',
    routes: {
      '/': (_) => const HomePage(),
    },
    theme: theme.lightTheme,
    darkTheme: theme.darkTheme,
  ));
}
