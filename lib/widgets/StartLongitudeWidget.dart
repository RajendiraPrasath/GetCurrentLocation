import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartLongitude extends StatefulWidget {
  const StartLongitude({Key? key}) : super(key: key);

  @override
  State<StartLongitude> createState() => _StartLongitudeState();
}

class _StartLongitudeState extends State<StartLongitude> {
  TextEditingController startingLongitudeController =
      TextEditingController(text: "79.199262");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: startingLongitudeController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Source Lon"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Source Longitude';
          }
          return null;
        },
      ),
    );
  }
}
