import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/Utills/Utility.dart';
import 'package:google_map_flutter/widgets/DistanceCalculatedWidget.dart';
import 'package:google_map_flutter/widgets/EndLatitudeWidget.dart';
import 'package:google_map_flutter/widgets/EndLongitudeWidget.dart';
import 'package:google_map_flutter/widgets/StartLatitudeWidget.dart';
import 'package:google_map_flutter/widgets/StartLongitudeWidget.dart';
import 'package:flutter/material.dart';
import 'Bloc/TotalDistanceBloc.dart';
import 'Bloc/TrackState.dart';
import 'Utills/UtilityRepository.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with WidgetsBindingObserver {
  //{"12.274291,79.199262},
  //     {"lat": 12.246975, "lng":79.224825},
  //     {"lat": 12.233513,79.071326},

  late TrackRepository trackRepository;
  late TotalDistanceBloc totalDistanceBloc;

  @override
  void initState() {
    trackRepository = TrackRepository();
    totalDistanceBloc = TotalDistanceBloc(trackRepository);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create) => TotalDistanceBloc(trackRepository),
        child: BlocConsumer<TotalDistanceBloc, TrackState>(
          bloc: totalDistanceBloc,
          builder: (context, state) {
            return baseWidgets();
          },
          listener: (context, state) {},
        ));
  }

  Widget baseWidgets() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
      ),
      body: SingleChildScrollView(
        child: Material(
          child: Form(
            key: Utility.formKey,
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StartLatitude(),
                    StartLongitude(),
                    EndLatitude(),
                    EndLongitude(),
                    DistanceCalculate(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  /*return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
      ),
      body: SingleChildScrollView(
        child: Material(
          child: Form(
            key: Utility.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const StartLatitude(),
                  const StartLongitude(),
                  const EndLatitude(),
                  const EndLongitude(),
                  const DistanceCalculate(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: totalDistance.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Text(totalDistance),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: distanceCalculatedButtonEnabled
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await startTracking();
                                    },
                                    child: const Text('Start Tracking'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (latLngList.isNotEmpty) {
                                        setState(() {
                                          distanceTravelled =
                                              "distanceTravelled : ${calculateTravelledDistance().toStringAsFixed(3)} KM";
                                        });
                                        stopTracking();
                                      } else if (timer == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Please start location tracking')),
                                        );
                                      }
                                    },
                                    child: const Text('Stop Tracking'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: distanceTravelled.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Text(distanceTravelled),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: latLngList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                key: latLngList[index],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                          "Date : ${DateTime.fromMillisecondsSinceEpoch(int.parse(latLngList.keys.elementAt(index)))}"),
                                      Text(
                                          "Lat : ${latLngList.values.elementAt(index)["latitude"]}"),
                                      Text(
                                          "Lon : ${latLngList.values.elementAt(index)["longitude"]}"),
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
  //}

  @override
  void dispose() {
    Utility.stopTracking();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
