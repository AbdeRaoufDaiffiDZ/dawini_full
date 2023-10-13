// import 'package:dawini_full/core/constants/constants.dart';
// import 'package:dawini_full/core/error/exception.dart';
// import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
// import 'package:dawini_full/patient_features/data/models/doctor_model.dart';
// import 'package:dawini_full/patient_features/data/models/weather_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// import '../../../helpers/json_reader.dart';
// import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockHttpClient mockHttpClient;
//   late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
//   late DoctorRemoteDataSourceImpl doctorRemoteDataSourceImpl;

//   const testCityName = 'New York';
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     weatherRemoteDataSourceImpl =
//         WeatherRemoteDataSourceImpl(client: mockHttpClient);
//     doctorRemoteDataSourceImpl = DoctorRemoteDataSourceImpl(mockHttpClient);
//   });

//   group("get current weather", () {
//     test('should return weather model when the respense code is 200', () async {
//       // arrange
//       when(mockHttpClient
//               .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
//           .thenAnswer((_) async => http.Response(
//               readJson("helpers\\dummy_data\\dummy_weather_responce.json"),
//               200));

//       // act
//       final result =
//           await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

//       // assert
//       expect(result, isA<WeatherModel>());
//     });
//   });
//   group("get doctor info", () {
//     test('should return doctor model when the respense code is 200', () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse(Urls.doctorInfoUrl()))).thenAnswer(
//           (_) async => http.Response(
//               readJson("helpers\\dummy_data\\dummy_doctor_respence.json"),
//               200));

//       // act
//       final result = await doctorRemoteDataSourceImpl.getDoctorsInfo();

//       // assert
//       expect(result, isA<DoctorModel>());
//     });
//   });

//   test(
//     'should throw a server exception when the response code is 404 or other',
//     () async {
//       //arrange
//       when(
//         mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))),
//       ).thenAnswer((_) async => http.Response('Not found', 404));

//       //act
//       final result =
//           weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

//       //assert
//       expect(result, throwsA(isA<ServerException>()));
//     },
//   );
//   test(
//     'should throw a server exception when the response code is 404 or other from firebase',
//     () async {
//       //arrange
//       when(
//         mockHttpClient.get(Uri.parse(Urls.doctorInfoUrl())),
//       ).thenAnswer((_) async => http.Response('Not found', 404));

//       //act
//       final result = doctorRemoteDataSourceImpl.getDoctorsInfo();

//       //assert
//       expect(result, throwsA(isA<ServerException>()));
//     },
//   );
// }
