import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndLongitude extends StatefulWidget {
  const EndLongitude({Key? key}) : super(key: key);

  @override
  State<EndLongitude> createState() => _EndLongitudeState();
}

class _EndLongitudeState extends State<EndLongitude> {
  TextEditingController endingLongitudeController =
      TextEditingController(text: "79.224825");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: endingLongitudeController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Destination Lon"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Destination Longitude';
          }
          return null;
        },
      ),
    );
  }
}
