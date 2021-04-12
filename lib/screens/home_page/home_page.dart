import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/build_generation_best.dart';
import 'package:pc_builder/screens/home_page/screen_components/appbar.dart';
import 'package:pc_builder/screens/new_build/new_build.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SoftButton(
              width: MediaQuery.of(context).size.width / 1.5,
              onTap: () => Navigator.of(context).push(FadeRoute(page: BuildGenerationBestScreen())),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      FontAwesomeIcons.brain,
                      size: 50,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                  ),
                  Text(
                    "Genereate build",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            SoftButton(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.all(12),
                onTap: () {
                  Provider.of<NewBuildProvider>(context, listen: false).newBuild();
                  Navigator.of(context).push(FadeRoute(page: NewBuildScreen()));
                },
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      FontAwesomeIcons.fistRaised,
                      size: 50,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
                  ),
                  Text(
                    "Select parts Manually",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
