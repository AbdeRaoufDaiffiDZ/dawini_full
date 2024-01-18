import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/repositories/patients_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';

class GetAppointmentLocalusecase {
  final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<List<PatientEntity>> excute() async {
    Either<Failure, List<PatientEntity>> info;
    info = await patientsRepository.GetAdoctorAppointment();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }
}

class DeletAppointmentLocalusecase {
  final PatientsRepository patientsRepository = PatientRepositoryImpl();
  Future<Either<Failure, String>> excute(PatientEntity patient) async {
    try {
      return await patientsRepository.DeleteAdoctorAppointment(patient);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class SetDoctorAppointmentusecase {
  final PatientsRepository patientsRepository = PatientRepositoryImpl();

  Future<Either<Failure, String>> excute(PatientEntity patient) async {
    try {
      return await patientsRepository.SetAdoctorAppointment(patient);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
