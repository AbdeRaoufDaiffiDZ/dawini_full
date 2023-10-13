// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:dawini_full/core/error/exception.dart';
// import 'package:dawini_full/core/error/failure.dart';
// import 'package:dawini_full/patient_features/data/models/weather_model.dart';
// import 'package:dawini_full/patient_features/data/repositories/weather_repository_impl.dart';
// import 'package:dawini_full/patient_features/domain/entities/weather.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
//   late WeatherRepositoryImpl weatherRepositoryImpl;
//   setUp(() {
//     mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
//     weatherRepositoryImpl = WeatherRepositoryImpl(
//         weatherRemoteDataSource: mockWeatherRemoteDataSource);
//   });

//   const testWeatherModel = WeatherModel(
//     cityName: 'New York',
//     main: 'Clouds',
//     description: 'few clouds',
//     iconCode: '02d',
//     temperature: 302.28,
//     pressure: 1009,
//     humidity: 70,
//   );

//   const testWeatherEntity = WeatherEntity(
//     cityName: 'New York',
//     main: 'Clouds',
//     description: 'few clouds',
//     iconCode: '02d',
//     temperature: 302.28,
//     pressure: 1009,
//     humidity: 70,
//   );

//   const testCityName = 'New York';

//   group('get current weather', () {
//     test(
//         'should get current weather when  a call to data source is successfule',
//         () async {
//       // arrange

//       when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
//           .thenAnswer((realInvocation) async => testWeatherModel);
//       // act
//       final result =
//           await weatherRepositoryImpl.getCurrentWeather(testCityName);
//       // assert
//       expect(result, equals(const Right(testWeatherEntity)));
//     });
//     test('should threw a server exception', () async {
//       // arrange

//       when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
//           .thenThrow(ServerException());
//       // act
//       final result =
//           await weatherRepositoryImpl.getCurrentWeather(testCityName);
//       // assert
//       expect(result, Left(ServerFailure(message: 'An error has occured')));
//     });

//     test('should threw a connection exception', () async {
//       // arrange

//       when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
//           .thenThrow(SocketException('Failed to connect to the network'));
//       // act
//       final result =
//           await weatherRepositoryImpl.getCurrentWeather(testCityName);
//       // assert
//       expect(result,
//           Left(ConnectionFailure(message: 'Failed to connect to the network')));
//     });
//   });
// }
