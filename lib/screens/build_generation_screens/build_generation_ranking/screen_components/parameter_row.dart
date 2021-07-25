import 'package:flutter/material.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_ranking/screen_components/drag_criteria.dart';

class ParameterRow extends StatelessWidget {
  final IconData icon;
  final Function(ComputerParameter) onAccept;
  final ComputerParameter selectedParam;

  const ParameterRow({Key key, this.icon, this.onAccept, this.selectedParam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Container(
                  height: 50,
                  child: DragTarget<ComputerParameter>(
                    onAccept: onAccept,
                    onWillAccept: (_) => true,
                    builder: (context, candidateData, rejectedData) {
                      if (candidateData.isNotEmpty)
                        return Center(
                          child: DragCriteria(
                            param: candidateData.first,
                          ),
                        );
                      else
                        return selectedParam != null
                            ? Center(
                                child: DragCriteria(
                                param: selectedParam,
                              ))
                            : Container();
                    },
                  ),
                )),
          )
        ],
      ),
    );
  }
}
