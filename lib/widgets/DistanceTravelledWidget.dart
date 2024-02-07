import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/Bloc/DistanceTravelledBloc.dart';
import 'package:google_map_flutter/Bloc/TrackState.dart';
import 'package:google_map_flutter/Utills/Utility.dart';

import '../Bloc/TrackEvent.dart';
import '../Utills/UtilityRepository.dart';

class DistanceTravelled extends StatefulWidget {
  const DistanceTravelled({Key? key}) : super(key: key);

  @override
  State<DistanceTravelled> createState() => _DistanceTravelledState();
}

class _DistanceTravelledState extends State<DistanceTravelled> {
  late TrackRepository trackRepository;
  late DistanceTravelledBloc distanceTravelledBloc;
  bool trackingStopped = false;
  String distanceTravelled = "";
  @override
  void initState() {
    trackRepository = TrackRepository();
    distanceTravelledBloc = DistanceTravelledBloc(trackRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) => DistanceTravelledBloc(trackRepository),
      child: BlocConsumer<DistanceTravelledBloc, TrackState>(
        bloc: distanceTravelledBloc,
        builder: (context, state) {
          if (state is TrackStartState) {
            return trackingDetailLayout(true);
          } else if (state is TrackStopState) {
            distanceTravelled = trackRepository.getDistanceTravelled();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                trackingDetailLayout(false),
                travelledDistanceLayout(),
                latLonListLayout()
              ],
            );
          } else {
            return Container();
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget trackingDetailLayout(bool start) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                if (start || trackingStopped) {
                  trackingStopped = false;
                  distanceTravelledBloc.add(TrackStartEvent());
                }
              },
              child: const Text('Start Tracking'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                if (start && !trackingStopped) {
                  trackingStopped = true;
                  distanceTravelledBloc.add(TrackStopEvent());
                } else if (Utility.timer == null || start || trackingStopped) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please start location tracking')),
                  );
                }
              },
              child: const Text('Stop Tracking'),
            ),
          ),
        ],
      ),
    );
  }

  Widget travelledDistanceLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: distanceTravelled.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(distanceTravelled),
            )
          : Container(),
    );
  }

  Widget latLonListLayout() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Utility.latLngList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  key: Utility.latLngList[index],
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                            "Date : ${DateTime.fromMillisecondsSinceEpoch(int.parse(Utility.latLngList.keys.elementAt(index)))}"),
                        Text(
                            "Lat : ${Utility.latLngList.values.elementAt(index)["latitude"]}"),
                        Text(
                            "Lon : ${Utility.latLngList.values.elementAt(index)["longitude"]}"),
                      ],
                    ),
                  ),
                );
              })
        ]));
  }
}
