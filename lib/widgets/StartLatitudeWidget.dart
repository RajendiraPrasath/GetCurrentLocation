import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartLatitude extends StatefulWidget {
  const StartLatitude({Key? key}) : super(key: key);

  @override
  State<StartLatitude> createState() => _StartLatitudeState();
}

class _StartLatitudeState extends State<StartLatitude> {
  TextEditingController startingLatitudeController =
      TextEditingController(text: "12.274291");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: startingLatitudeController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Source Lat"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Source Latitude';
          }
          return null;
        },
      ),
    );
  }
}
