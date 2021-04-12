import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';

class CriteriaPicker extends StatelessWidget {
  final String text;
  final List<ComputerParameter> parameters;
  final Function(ComputerParameter) onTap;
  final ComputerParameter selected;

  const CriteriaPicker({Key key, this.text, this.parameters, this.onTap, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SoftContainer(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 10),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Text(
              text,
              style: theme.textTheme.headline1,
            ),
          ),
          Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Expanded(
                    child: SoftContainer(
                      child: DropdownButton<ComputerParameter>(
                        icon: Container(),
                        value: selected,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: onTap,
                        items: parameters
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Center(
                                  child: AutoSizeText(mapText(e),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headline1),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  mapText(ComputerParameter param) {
    switch (param) {
      case ComputerParameter.none:
        return "--";
      case ComputerParameter.price:
        return "Price";
      case ComputerParameter.consumption:
        return "Consumption";
      case ComputerParameter.contentCreation:
        return "Content Creation";
      case ComputerParameter.multitasking:
        return "Multitasking";
      case ComputerParameter.gaming:
        return "Gaming";
      case ComputerParameter.storage:
        return "Storage";
      default:
        return "--";
    }
  }
}
