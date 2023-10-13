import 'package:dawini_full/introduction_feature/domain/entity/introduction_entity.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_current_weather.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:mockito/annotations.dart';
import 'package:dawini_full/patient_features/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

@GenerateMocks([
  // WeatherRepository,
  // WeatherRemoteDataSource,
  // GetCurrentWeatherUseCase,
  // DoctorRepository,
  // DoctorRemoteDataSource,
  // GetDoctorsInfoUseCase,
  IntroductionRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
