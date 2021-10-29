import 'package:flutter/material.dart';

AppBar hiAppBar(
    {required String title,
    required String rightTitle,
    required VoidCallback rightButtonClick}) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
