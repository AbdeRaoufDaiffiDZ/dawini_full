import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorAuthStateUseCase {
  final DoctorRepository repository;

  DoctorAuthStateUseCase({required this.repository});

  Future<Either<Failure, UserCredential>> execute(email, password) async {
    return repository.authDoctor(email, password);
  }
}
