import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future<Either<Failure, UserCredential>> authDoctor(email, password);
}
