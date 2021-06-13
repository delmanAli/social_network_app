import 'package:flutter/material.dart';

void navigateTo({
  @required BuildContext context,
  @required Widget widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
//,,,,,,,,,,,,,,,,,,,,,,,,,,
void navigateToNamed({
  @required BuildContext context,
  @required String widget,
}) =>
    Navigator.pushNamed(
      context,
      widget,
    );
void navigateReplacementNamed({
  @required BuildContext context,
  @required String widget,
}) =>
    Navigator.pushReplacementNamed(
      context,
      widget,
    );
