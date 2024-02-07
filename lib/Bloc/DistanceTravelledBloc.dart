import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/Bloc/TrackEvent.dart';

import '../Utills/UtilityRepository.dart';
import 'TrackState.dart';

class DistanceTravelledBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository trackRepository;
  DistanceTravelledBloc(this.trackRepository) : super(TrackStartState()) {
    on<TrackStartEvent>(trackStartEvent);
    on<TrackStopEvent>(trackStopEvent);
  }

  FutureOr<void> trackStartEvent(
      TrackStartEvent event, Emitter<TrackState> emit) {
    emit(TrackStartState());
    trackRepository.startTracking();
  }

  FutureOr<void> trackStopEvent(
      TrackStopEvent event, Emitter<TrackState> emit) {
    trackRepository.stopTracking();
    emit(TrackStopState());
  }
}
