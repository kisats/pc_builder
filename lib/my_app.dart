import 'package:flutter/material.dart';
import 'package:pc_builder/providers/algorithm_selection_provider.dart';
import 'package:pc_builder/providers/build_generation/build_generator_provider.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/ranking_autobuild_provider.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:pc_builder/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NewBuildProvider>(
            create: (context) => NewBuildProvider(),
          ),
          ChangeNotifierProvider<BWAutoBuildProvider>(
            create: (context) => BWAutoBuildProvider(),
          ),
          ChangeNotifierProvider<RankingAutoBuildProvider>(
            create: (context) => RankingAutoBuildProvider(),
          ),
          ChangeNotifierProvider<BuildGeneratorProvider>(
            create: (context) => BuildGeneratorProvider(),
          ),
          ChangeNotifierProvider<AlgorithmSelectionProvider>(
            create: (context) => AlgorithmSelectionProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.compact,
              highlightColor: Color.fromRGBO(88, 170, 244, 0.1),
              /* Color.fromRGBO(169, 184, 206, 0.5), */
              scaffoldBackgroundColor: Color.fromRGBO(236, 240, 244, 1.0),
              cursorColor: Color.fromRGBO(90, 112, 130, 1.0),
              buttonColor: Color.fromRGBO(85, 108, 138, 1.0),
              shadowColor: Color.fromRGBO(179, 194, 216, 1.0),
              accentColor: Color.fromRGBO(88, 191, 244, 1.0),
              splashColor: Color.fromRGBO(88, 191, 244, 0.3),
              iconTheme: IconThemeData(
                color: Color.fromRGBO(169, 184, 206, 1.0),
              ),
              cardColor: Colors.white,
              textTheme: TextTheme(
                  headline1: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(78, 100, 128, 1.0),
                      fontWeight: FontWeight.w700),
                  headline2: TextStyle(
                      color: Color.fromRGBO(110, 132, 150, 1.0),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                  headline3: TextStyle(color: Color.fromRGBO(146, 153, 161, 1.0), fontSize: 16),
                  headline4: TextStyle(
                      color: Color.fromRGBO(169, 184, 206, 1.0),
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(169, 184, 206, 1.0),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                  border: InputBorder.none),
              fontFamily: "Quicksand"),
          home: HomePage(),
        ));
  }
}
