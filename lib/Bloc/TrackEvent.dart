import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TrackEvent extends Equatable {
  const TrackEvent();
}

class GetTotalDistance extends TrackEvent {
  @override
  List<Object?> get props => [];
}

class TrackStartEvent extends TrackEvent {
  @override
  List<Object?> get props => [];
}

class TrackStopEvent extends TrackEvent {
  @override
  List<Object?> get props => [];
}
