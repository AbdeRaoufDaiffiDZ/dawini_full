import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/domain/repositories/clinic_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClinicAuthStateUseCase {
  final ClinicRepository repository;

  ClinicAuthStateUseCase({required this.repository});

  Future<Either<Failure, UserCredential>> execute(email, password) async {
    return repository.authClinic(email, password);
  }
}
