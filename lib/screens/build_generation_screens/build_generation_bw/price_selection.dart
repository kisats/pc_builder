import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_range_slider.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/build_generation_process.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/value_slider.dart';
import 'package:provider/provider.dart';

class PriceSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: BuildGenerationAppBar(),
      body: Consumer<AutoBuildProvider>(
        builder: (_, state, __) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SoftContainer(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Select maximal computer build cost",
                        style: theme.textTheme.headline2.copyWith(fontWeight: FontWeight.w500)),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SoftSlider(
                        min: 0,
                        max: 10000,
                        handlerWidth: 60,
                        value: state.maxBuildPrice,
                        suffix: "€",
                        onChanged: (_, start, end) {
                          state.setMaxPrice(start);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ActionButton(
                title: "Generate",
                disabled: state.maxBuildPrice == 0 || state.maxBuildPrice == null,
                onTap: () async {
                  state.generateBuilds();
                  Navigator.of(context).push(FadeRoute(page: BuildGenerationProcess()));
                  //var builds = await state.getBuilds();
                  /*  Navigator.of(context).push(FadeRoute(
                          page: GeneratedBuildsScreen(
                        builds: builds,
                      ))); */
                  /* state.submit();
                  Navigator.of(context).push(FadeRoute(page: BuildGenerationWorstScreen())); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
