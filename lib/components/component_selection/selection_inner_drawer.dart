import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class SelectionInnerDrawer extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  final Widget drawer;
  final Widget scaffold;

  const SelectionInnerDrawer({Key key, this.innerDrawerKey, this.drawer, this.scaffold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (_, state, child) => InnerDrawer(
          key: innerDrawerKey,
          onTapClose: true,
          swipe: state.canBeOpened,
          colorTransitionScaffold: Theme.of(context).shadowColor.withOpacity(0.15),
          offset: IDOffset.only(right: 0.75),
          scale: IDOffset.horizontal(1.0),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.4),
                offset: Offset(0.0, 2.0),
                blurRadius: 2,
                spreadRadius: 1)
          ],
          proportionalChildArea: true,
          borderRadius: 10,
          rightAnimationType: InnerDrawerAnimation.linear,
          backgroundDecoration: BoxDecoration(
              color: Color.alphaBlend(Theme.of(context).shadowColor.withOpacity(0.45),
                  Theme.of(context).scaffoldBackgroundColor)),
          duration: Duration(milliseconds: 160),
          rightChild: Padding(padding: const EdgeInsets.only(left: 12), child: state.canBeOpened ? drawer : Container()),
          scaffold: child),
      child: scaffold,
    );
  }
}
