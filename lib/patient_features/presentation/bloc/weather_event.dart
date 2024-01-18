import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class onCityChanged extends WeatherEvent {
  final String cityName;

  const onCityChanged({required this.cityName});
  @override
  List<Object> get props => [cityName];
}