import 'package:equatable/equatable.dart';

abstract class TrackState extends Equatable {}

class TotalDistanceInitState extends TrackState {
  @override
  List<Object?> get props => [];
}

class TotalDistanceState extends TrackState {
  final String totalDistance;
  TotalDistanceState(this.totalDistance);
  @override
  List<Object?> get props => [totalDistance];
}

class TrackStartState extends TrackState {
  @override
  List<Object?> get props => [];
}

class TrackStopState extends TrackState {
  @override
  List<Object?> get props => [];
}
