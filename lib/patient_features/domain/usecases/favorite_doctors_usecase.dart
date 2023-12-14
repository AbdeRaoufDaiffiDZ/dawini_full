// import 'package:dartz/dartz.dart';
// import 'package:dawini_full/core/error/failure.dart';
// import 'package:dawini_full/patient_features/data/repositories/patients_repository_impl.dart';
// import 'package:dawini_full/patient_features/domain/entities/patient.dart';
// import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';
// import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';

// class GetFavoriteDoctorsUseCase {
//   final DoctorRepository patientsRepository = Doctorr();


//   Future<List<PatientEntity>> excute() async {
//     Either<Failure, List<PatientEntity>> info;
//     info = await patientsRepository.GetAdoctorAppointment();

//     return info.fold(
//         (l) => throw (ServerFailure(message: l.message)), (r) => r);
//   }
// }

// class SetDoctorAppointmentusecase {
//   static final PatientsRepository patientsRepository = PatientRepositoryImpl();

//   static Future<void> excute(PatientEntity patient) async {
//     try {
//       await patientsRepository.SetAdoctorAppointment(patient);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
