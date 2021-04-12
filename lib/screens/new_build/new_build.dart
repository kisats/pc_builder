import 'package:flutter/material.dart';
import 'package:pc_builder/components/add_part_card.dart';
import 'package:pc_builder/components/component_build_card.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:pc_builder/screens/case_selection/case_selection.dart';
import 'package:pc_builder/screens/case_selection/screen_components/case_card.dart';
import 'package:pc_builder/screens/cooler_selection/cooler_selection.dart';
import 'package:pc_builder/screens/cooler_selection/screen_components/cooler_card.dart';
import 'package:pc_builder/screens/cpu_selection.dart/cpu_selection.dart';
import 'package:pc_builder/screens/cpu_selection.dart/screen_components/cpu_card.dart';
import 'package:pc_builder/screens/graphics_card_selection/graphic_card_selection.dart';
import 'package:pc_builder/screens/graphics_card_selection/screen_components/graphics_card_card.dart';
import 'package:pc_builder/screens/motherboard_selection.dart/motherboard_selection.dart';
import 'package:pc_builder/screens/motherboard_selection.dart/screen_components/motherboard_card.dart';
import 'package:pc_builder/screens/psu_selection/psu_selection.dart';
import 'package:pc_builder/screens/psu_selection/screen_components/psu_card.dart';
import 'package:pc_builder/screens/ram_selection/ram_selection.dart';
import 'package:pc_builder/screens/ram_selection/screen_components/ram_card.dart';
import 'package:pc_builder/screens/storage_selection/screen_components/storage_card.dart';
import 'package:pc_builder/screens/storage_selection/storage_selection.dart';
import 'package:provider/provider.dart';

import 'screen_components/appbar.dart';

class NewBuildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuildAppBar(),
      body: Consumer<NewBuildProvider>(
          builder: (_, state, __) => SoftListView([
                state.cpu == null
                    ? AddPartCard(
                        icon: PCParts.cpu,
                        text: "Processor",
                        onTap: () => Navigator.of(context).push(FadeRoute(page: CPUSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Processor",
                        icon: PCParts.cpu,
                        componentCard: CPUCard(
                          cpu: state.cpu,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () => Navigator.of(context).push(FadeRoute(page: CPUSelection())),
                        remove: state.removeCPU,
                      ),
                state.motherboard == null
                    ? AddPartCard(
                        icon: PCParts.motherboard,
                        text: "Motherboard",
                        onTap: () =>
                            Navigator.of(context).push(FadeRoute(page: MotherboardSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Motherboard",
                        icon: PCParts.motherboard,
                        componentCard: MotherboardCard(
                          mb: state.motherboard,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () =>
                            Navigator.of(context).push(FadeRoute(page: MotherboardSelection())),
                        remove: state.removeMotherboard,
                      ),
                state.gpu == null
                    ? AddPartCard(
                        icon: PCParts.videocard,
                        text: "Graphics Card",
                        onTap: () =>
                            Navigator.of(context).push(FadeRoute(page: GraphicsCardSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Graphics Card",
                        icon: PCParts.videocard,
                        componentCard: GraphicCardCard(
                          videoCard: state.gpu,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () =>
                            Navigator.of(context).push(FadeRoute(page: GraphicsCardSelection())),
                        remove: state.removeVideoCard,
                      ),
                state.ram == null
                    ? AddPartCard(
                        icon: PCParts.memory,
                        text: "RAM",
                        onTap: () => Navigator.of(context).push(FadeRoute(page: RAMSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "RAM",
                        icon: PCParts.memory,
                        componentCard: RAMCard(
                          ram: state.ram,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () => Navigator.of(context).push(FadeRoute(page: RAMSelection())),
                        remove: state.removeRAM,
                      ),
                state.ssd == null
                    ? AddPartCard(
                        icon: PCParts.ssd,
                        text: "Storage",
                        onTap: () =>
                            Navigator.of(context).push(FadeRoute(page: StorageSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Storage",
                        icon: PCParts.ssd,
                        componentCard: StorageCard(
                          ssd: state.ssd,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () =>
                            Navigator.of(context).push(FadeRoute(page: StorageSelection())),
                        remove: state.removeStorage,
                      ),
                state.psu == null
                    ? AddPartCard(
                        icon: PCParts.supply,
                        text: "Power Supply",
                        onTap: () => Navigator.of(context).push(FadeRoute(page: PSUSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Power Supply",
                        icon: PCParts.supply,
                        componentCard: PSUCard(
                          psu: state.psu,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () => Navigator.of(context).push(FadeRoute(page: PSUSelection())),
                        remove: state.removePSU,
                      ),
                state.cooler == null
                    ? AddPartCard(
                        icon: PCParts.cooler,
                        text: "CPU Cooler",
                        onTap: () => Navigator.of(context).push(FadeRoute(page: CoolerSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "CPU Cooler",
                        icon: PCParts.cooler,
                        componentCard: CoolerCard(
                          cooler: state.cooler,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () =>
                            Navigator.of(context).push(FadeRoute(page: CoolerSelection())),
                        remove: state.removeCooler,
                      ),
                state.pcCase == null
                    ? AddPartCard(
                        icon: PCParts.case_icon,
                        text: "Case",
                        onTap: () => Navigator.of(context).push(FadeRoute(page: CaseSelection())),
                      )
                    : ComponentBuildCard(
                        componentName: "Case",
                        icon: PCParts.case_icon,
                        componentCard: CaseCard(
                          model: state.pcCase,
                          showPlus: false,
                          margin: EdgeInsets.zero,
                        ),
                        change: () => Navigator.of(context).push(FadeRoute(page: CaseSelection())),
                        remove: state.removeCase,
                      ),
              ], ScrollController())),
    );
  }
}
