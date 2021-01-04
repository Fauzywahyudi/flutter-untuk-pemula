import 'package:flutter/material.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/edge_inset.dart';

class FillTextField extends StatelessWidget {
  final Widget child;

  const FillTextField({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: defaultEdge,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: textFormField,
      child: child,
    );
  }
}
