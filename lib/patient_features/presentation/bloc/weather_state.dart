import 'package:dawini_full/patient_features/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  WeatherLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class WeatherLoadedFailue extends WeatherState {
  final String message;

  WeatherLoadedFailue({required this.message});
  @override
  List<Object> get props => [message];
}
