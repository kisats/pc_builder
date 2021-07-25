import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/autobuild.dart';

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
      margin: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
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
              flex: 8,
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
                                  child: AutoSizeText(mapComputerParameter(e),
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
}

class CriteriaPickerRow extends StatelessWidget {
  final String text;
  final List<ComputerParameter> parameters;
  final Function(ComputerParameter) onTap;
  final ComputerParameter selected;

  const CriteriaPickerRow({Key key, this.text, this.parameters, this.onTap, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Flex(
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
            flex: 8,
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
                                child: AutoSizeText(mapComputerParameter(e),
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
    );
  }
}
