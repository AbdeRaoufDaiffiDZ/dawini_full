import 'package:dawini_full/introduction_feature/data/data_source/local_data_source.dart';
import 'package:dawini_full/introduction_feature/data/repositoryImpl/itroduction_repository_impl.dart';
import 'package:dawini_full/introduction_feature/domain/repository/introductionRepository.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/check_status_is_watched_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/choosen_language_ucecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/ignore_intoduction_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/is_introduction_watched_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_language_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/user_type_usecase.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/data/repositories/clinic_repository_impl.dart';
import 'package:dawini_full/patient_features/data/repositories/doctor_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/repositories/clinic_repository.dart';
import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';
import 'package:dawini_full/patient_features/domain/usecases/clinic_auth_state_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctor_auth_satet_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_clinics_info.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // bloc
  // locator.registerFactory(() => WeatherBloc(locator()));
  locator.registerFactory(() => DoctorBloc(locator(), locator()));
  locator.registerFactory(() => DoctorAuthBloc(locator()));
  locator.registerFactory(() => IntroductionBloc(locator(), locator(),
      locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => ClinicsBloc(locator(), locator()));

  // usecase
  // locator.registerLazySingleton(
  //     () => GetCurrentWeatherUseCase(weatherRepository: locator()));
  locator.registerLazySingleton(
      () => GetDoctorsInfoUseCase(doctorRepository: locator()));
  locator.registerLazySingleton(
      () => GetDoctorsStreamInfoUseCase(doctorRepository: locator()));
  locator.registerLazySingleton(
      () => DoctorAuthStateUseCase(repository: locator()));
  // clinics part
  locator.registerLazySingleton(
      () => GetClinicsInfoUseCase(clinicRepository: locator()));
  locator.registerLazySingleton(
      () => GetClinicsStreamInfoUseCase(clinicRepository: locator()));
  locator.registerLazySingleton(
      () => ClinicAuthStateUseCase(repository: locator()));

  locator.registerLazySingleton(
      () => CheckWatchingStatusUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => SetLanguageUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => ChossenLanguageUseCase(repository: locator()));
  locator.registerLazySingleton(() => SetTypeUseCase(repository: locator()));
  locator.registerLazySingleton(() => UserTypeUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => IgnorIntroductionUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => IsIntroductionWatchedUseCase(repository: locator()));
  // repository
  // locator.registerLazySingleton<WeatherRepository>(
  //   () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  // );
  locator.registerLazySingleton<DoctorRepository>(
      () => DcotrRepositoryImpl(doctorRemoteDataSource: locator()));

  // clinics part
  locator.registerLazySingleton<ClinicRepository>(
      () => ClinicRepositoryImpl(clinicsRemoteDataSource: locator()));
  locator.registerLazySingleton<IntroductionRepository>(
      () => IntroductionRepositoryImpl(dataSource: locator()));

  locator.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(prefs: locator()));

  locator.registerLazySingleton<ClinicsRemoteDataSource>(
      () => ClinicsRemoteDataSourceImpl(locator(), locator(), locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FirebaseDatabase());
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
}
