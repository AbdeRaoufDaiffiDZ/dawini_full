import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';

abstract class PatientsRepository {
  Future<Either<Failure, List<PatientEntity>>> GetAdoctorAppointment();
  Future<Either<Failure, String>> SetAdoctorAppointment(PatientEntity patient);
  Future<Either<Failure, String>> DeleteAdoctorAppointment(
      PatientEntity patient);
  Future<Either<Failure, List<DoctorEntity>>> getFavoriteDoctors();
  Future<Either<Failure, List<PatientEntity>>> SetFavoriteDoctor(
      DoctorEntity doctor);
}
