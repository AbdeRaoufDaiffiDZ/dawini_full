import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/weather.dart';
import 'package:dawini_full/patient_features/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase({required this.weatherRepository});
  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
