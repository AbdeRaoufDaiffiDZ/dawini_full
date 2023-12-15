// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo();
  Future<Either<Failure, List<DoctorEntity>>> getFavoriteDoctors();
  Future<Either<Failure, List<DoctorEntity>>> setFavoriteDoctors();
  Future<bool> SetDoctorAppointmentOnline(PatientEntity patientInfo);
  Future<bool> DeleteDoctorAppointmentOnline(PatientEntity patientInfo);

  Stream<List<DoctorEntity>> streamDoctors();
  Future<Either<Failure, UserCredential>> authDoctor(email, password);
}
