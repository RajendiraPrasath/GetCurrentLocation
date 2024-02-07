import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndLatitude extends StatefulWidget {
  const EndLatitude({Key? key}) : super(key: key);

  @override
  State<EndLatitude> createState() => _EndLatitudeState();
}

class _EndLatitudeState extends State<EndLatitude> {
  TextEditingController endingLatitudeController =
      TextEditingController(text: "12.246975");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextFormField(
        controller: endingLatitudeController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: "Destination Lat"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Destination Latitude';
          }
          return null;
        },
      ),
    );
  }
}
