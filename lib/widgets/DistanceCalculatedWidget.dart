import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/Bloc/TotalDistanceBloc.dart';
import 'package:google_map_flutter/Bloc/TrackEvent.dart';
import 'package:google_map_flutter/Bloc/TrackState.dart';
import 'package:google_map_flutter/Utills/Utility.dart';
import 'package:google_map_flutter/Utills/UtilityRepository.dart';
import 'package:google_map_flutter/widgets/DistanceTravelledWidget.dart';

class DistanceCalculate extends StatefulWidget {
  const DistanceCalculate({Key? key}) : super(key: key);

  @override
  State<DistanceCalculate> createState() => _DistanceCalculateState();
}

class _DistanceCalculateState extends State<DistanceCalculate> {
  late TrackRepository trackRepository;
  late TotalDistanceBloc totalDistanceBloc;
  @override
  void initState() {
    trackRepository = TrackRepository();
    totalDistanceBloc = TotalDistanceBloc(trackRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) => TotalDistanceBloc(trackRepository),
      child: BlocConsumer<TotalDistanceBloc, TrackState>(
        bloc: totalDistanceBloc,
        builder: (context, state) {
          if (state is TotalDistanceInitState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [elevatedButton()]);
          } else if (state is TotalDistanceState) {
            var totalDistance = state;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  elevatedButton(),
                  distanceText(distance: totalDistance.totalDistance),
                  const DistanceTravelled()
                ]);
          } else {
            return Container();
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget elevatedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (Utility.formKey.currentState!.validate()) {
              if (Utility.distanceCalculatedButtonEnabled) {
                Utility.distanceCalculatedButtonEnabled = false;
                totalDistanceBloc.add(GetTotalDistance());
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill input')),
              );
            }
          });
        },
        child: const Text('Calculate Distance'),
      ),
    );
  }

  Widget distanceText({String distance = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: distance.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(distance),
            )
          : Container(),
    );
  }
}
