// // ignore_for_file: unused_local_variable

// import 'package:dartz/dartz.dart';
// import 'package:dawini_full/patient_features/domain/entities/weather.dart';
// import 'package:dawini_full/patient_features/domain/usecases/get_current_weather.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   GetCurrentWeatherUseCase? getCurrentWeatherUseCase;
//   MockWeatherRepository? mockWeatherRepository;
//   const testWeatherDetails = WeatherEntity(
//       cityName: "New York",
//       main: 'clouds',
//       description: 'few clouds',
//       iconCode: '02d',
//       temperature: 302.28,
//       pressure: 1009,
//       humidity: 70);
//   const testCityName = 'New York';
//   setUp(() {
//     mockWeatherRepository = MockWeatherRepository();
//     getCurrentWeatherUseCase =
//         GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository!);
//   });
//   test('should get current weather deatils from repository ', () async {
// // arrange
//     when(mockWeatherRepository!.getCurrentWeather(testCityName))
//         .thenAnswer((_) async => const Right(testWeatherDetails));

//     // act

//     final result = await getCurrentWeatherUseCase!.execute(testCityName);
//     // assert
//     expect(result, const Right(testWeatherDetails));
//   });
// }
