import 'package:flutter/material.dart';

class AboutPopupView extends StatelessWidget {
  const AboutPopupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("About"),
      content: const Column(
        children: [
          Text(
              "This app was created by Isa Tippens for the individual project of Assignment 1 for COS 738."),
          Text("Student Number: 4034973"),
          Text("University of the Western Cape"),
          Text("2023"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
