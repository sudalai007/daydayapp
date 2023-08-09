import 'package:daydayapp/firebase_options.dart';
import 'package:daydayapp/view/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Project Templete",
      theme: ThemeData(),
      home: HomePage(),
    ),
  ));
}
