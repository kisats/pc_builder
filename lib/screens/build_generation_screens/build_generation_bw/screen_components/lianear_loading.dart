import 'package:flutter/material.dart';

class SoftLinearLoading extends StatelessWidget {

  final double value;

  const SoftLinearLoading({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LinearProgressIndicator(
        backgroundColor: Theme.of(context).toggleableActiveColor.withOpacity(0.3),
        value: value,
        minHeight: 8,
      ),
    );
  }
}
