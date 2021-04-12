import 'package:flutter/material.dart';

class PriceChip extends StatelessWidget {
  final double price;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PriceChip({Key key, this.price, this.padding, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.green[900].withOpacity(0.67),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Icon(
              Icons.euro_rounded,
              size: 17,
              color: Colors.white,
            ),
          ),
          Text(
            price?.toStringAsFixed(2) ?? " -- ",
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
