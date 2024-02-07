import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/Bloc/TrackState.dart';
import 'package:google_map_flutter/Utills/UtilityRepository.dart';

import 'TrackEvent.dart';

class TotalDistanceBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository trackRepository;
  TotalDistanceBloc(this.trackRepository) : super(TotalDistanceInitState()) {
    on<GetTotalDistance>((event, emit) {
      emit(TotalDistanceInitState());
      var totalDistance = trackRepository.getTotalDistance();
      emit(TotalDistanceState(totalDistance));
    });
  }
}
