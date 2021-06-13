import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

Widget appBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      actions: actions,
      leading: IconButton(
        icon: Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title),
      titleSpacing: 5,
    );
