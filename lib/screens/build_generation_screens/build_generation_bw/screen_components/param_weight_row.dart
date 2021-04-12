import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_container.dart';

class WeightRow extends StatelessWidget {
  final String name;
  final double weight;
  final double value;

  const WeightRow({Key key, this.name, this.weight, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headline2.copyWith(fontWeight: FontWeight.w500, fontSize: 16);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: AutoSizeText(
              name,
              maxLines: 1,
              style: style,
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 9, right: 9),
              child: SoftContainer(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    backgroundColor: theme.toggleableActiveColor.withOpacity(0.25),
                    value: value,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: AutoSizeText(
              weight.toStringAsFixed(3),
              maxLines: 1,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
