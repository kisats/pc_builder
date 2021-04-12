import 'package:flutter/material.dart';

class SoftListView extends StatelessWidget {
  final Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final List<Widget> items;
  final ScrollController scroll;

  const SoftListView._(this.itemBuilder, this.itemCount, this.items, this.scroll);

  const SoftListView.builder(
      Function(BuildContext, int) itemBuilder, int itemCount, ScrollController scrollController)
      : this._(itemBuilder, itemCount, null, scrollController);

  const SoftListView(List<Widget> items, ScrollController scrollController)
      : this._(null, null, items, scrollController);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        controller: scroll,
        child: ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                stops: [0.0, 0.03, 0.97, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: items != null
                ? ListView(
                    controller: scroll,
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    physics: BouncingScrollPhysics(),
                    children: items,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    physics: BouncingScrollPhysics(),
                    controller: scroll,
                    itemCount: itemCount,
                    itemBuilder: itemBuilder,
                  )));
  }
}
