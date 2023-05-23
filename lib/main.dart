import 'package:flutter/material.dart';
import 'package:mvvm_architechture_provider_http/res/app_context_extention.dart';
import 'package:mvvm_architechture_provider_http/view/details/movie_details_screen.dart';
import 'package:mvvm_architechture_provider_http/view/home/home_screen.dart';

import 'models/movies_list/movies_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: context.resources.color.colorPrimary,
        //accentColor: context.resources.color.colorAccent,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        MovieDetailsScreen.id: (context) => MovieDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as Movie),
      },
    );
  }
}
