// import 'package:dartz/dartz.dart';
// import 'package:dawini_full/core/error/failure.dart';
// import 'package:dawini_full/patient_features/data/models/weather_model.dart';
// import 'package:dawini_full/patient_features/domain/entities/weather.dart';
// import 'package:dawini_full/patient_features/presentation/bloc/weather_bloc.dart';
// import 'package:dawini_full/patient_features/presentation/bloc/weather_event.dart';
// import 'package:dawini_full/patient_features/presentation/bloc/weather_state.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
//   late WeatherBloc weatherBloc;

//   setUp(() {
//     mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
//     weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
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

//   test('the inistial state should be empty', () {
// // arrange
//     expect(weatherBloc.state, WeatherEmpty());

// // act

// // assert
//   });

//   blocTest<WeatherBloc, WeatherState>(
//       'should emit [Weather loading, Weather Loaded ] when data is gotten ',
//       build: () {
//         when(mockGetCurrentWeatherUseCase.execute(testCityName))
//             .thenAnswer((realInvocation) async => Right(testWeatherEntity));
//         return weatherBloc;
//       },
//       act: (bloc) {
//         bloc.add(onCityChanged(cityName: testCityName));
//       },
//       wait: Duration(milliseconds: 500),
//       expect: () =>
//           [WeatherLoading(), WeatherLoaded(result: testWeatherEntity)]);

//   blocTest<WeatherBloc, WeatherState>(
//       'should emit [Weather loading, Weather failure ] when data is failed ',
//       build: () {
//         when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
//             (realInvocation) async =>
//                 Left(ServerFailure(message: 'Server failure')));
//         return weatherBloc;
//       },
//       act: (bloc) {
//         bloc.add(onCityChanged(cityName: testCityName));
//       },
//       wait: Duration(milliseconds: 500),
//       expect: () =>
//           [WeatherLoading(), WeatherLoadedFailue(message: 'Server failure')]);
// }
