import 'package:flutter/material.dart';

class SoftListView extends StatelessWidget {
  final Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final List<Widget> items;

  const SoftListView._(this.itemBuilder, this.itemCount, this.items);

  const SoftListView.builder(Function(BuildContext, int) itemBuilder, int itemCount)
      : this._(itemBuilder, itemCount, null);

  const SoftListView(List<Widget> items) : this._(null, null, items);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        controller: ScrollController(),
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    physics: BouncingScrollPhysics(),
                    children: items,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    physics: BouncingScrollPhysics(),
                    itemCount: itemCount,
                    itemBuilder: itemBuilder,
                  )));
  }
}
