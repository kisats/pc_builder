import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/autobuild.dart';

class DragCriteria extends StatelessWidget {
  final ComputerParameter param;

  const DragCriteria({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<ComputerParameter>(
        data: param,
        childWhenDragging: Opacity(opacity: 0.5, child: _draggable(context)),
        child: _draggable(context),
        feedback: _draggable(context));
  }

  _draggable(BuildContext context) {
    return SoftContainer(
      padding: const EdgeInsets.all(8),
      child: Text(
        mapComputerParameter(param),
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
