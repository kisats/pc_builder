import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:pc_builder/screens/cpu_selection.dart/cpu_selection.dart';
import 'package:provider/provider.dart';

import 'screen_components/appbar.dart';

class NewBuildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuildAppBar(),
      body: Consumer<NewBuildProvider>(
          builder: (_, state, __) => SoftListView([
                AddPartCard(
                  icon: PCParts.cpu,
                  text: "Processor",
                  onTap: () {
                    Navigator.of(context).push(FadeRoute(page: CPUSelection()));
                  },
                ),
                AddPartCard(
                  icon: PCParts.motherboard,
                  text: "Motherboard",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.videocard,
                  text: "Graphics Card",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.memory,
                  text: "RAM",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.ssd,
                  text: "Storage",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.supply,
                  text: "Power Supply",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.cooler,
                  text: "CPU Cooler",
                  onTap: () {},
                ),
                AddPartCard(
                  icon: PCParts.case_icon,
                  text: "Case",
                  onTap: () {},
                ),
              ])),
    );
  }
}

class AddPartCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const AddPartCard({Key key, this.icon, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SoftContainer(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      icon,
                      color: Theme.of(context).textTheme.headline1.color,
                      size: 28,
                    ),
                  ),
                  Text(text, style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20)),
                ],
              ),
              Icon(FontAwesomeIcons.plus),
            ],
          ),
        ),
      ),
    );
  }
}
