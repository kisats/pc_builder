import 'package:flutter/material.dart';
import 'package:pc_builder/components/build_card.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/screens/build_generation_screens/generated_builds/screen_components/appbar.dart';

class GeneratedBuildsScreen extends StatelessWidget {
  final List<Build> builds;

  const GeneratedBuildsScreen({Key key, this.builds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneratedBuildsAppBar(),
      body: SoftListView(
          builds
              .map((e) => BuildCard(
                    pcBuild: e,
                    number: builds.indexOf(e) + 1,
                  ))
              .toList(),
          ScrollController()),
    );
  }
}
