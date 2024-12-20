import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/remote_data_source.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DcotrRepositoryImpl implements DoctorRepository {
  static final DoctorRemoteDataSource doctorRemoteDataSource =
      DoctorRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInfo() async {
    try {
      final result = await doctorRemoteDataSource.getDoctorsInfo();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Stream<List<DoctorEntity>> streamDoctors() {
    try {
      final result = doctorRemoteDataSource.streamDoctors();
      return result;
    } on ServerException {
      throw ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw ConnectionFailure(message: 'Failed to connect to the network');
    }
  }

  @override
  Future<Either<Failure, UserCredential>> authDoctor(email, password) async {
    try {
      final result = await doctorRemoteDataSource.authDoctor(email, password);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticatinFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getFavoriteDoctors() {
    // TODO: implement getFavoriteDoctors
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> setFavoriteDoctors() {
    // TODO: implement setFavoriteDoctors
    throw UnimplementedError();
  }

  @override
  Future<bool> SetDoctorAppointmentOnline(PatientEntity patientInfo) {
    try {
      final result = doctorRemoteDataSource.SetDoctorAppointmentOnline(
          PatientModel.fromMap(patientInfo.toMap()));

      return result;
    } on ServerException {
      throw ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw ConnectionFailure(message: 'Failed to connect to the network');
    }
  }

  @override
  Future<bool> DeleteDoctorAppointmentOnline(PatientEntity patientInfo) {
    try {
      final result = doctorRemoteDataSource.RemoveDoctorAppointmentOnline(
          PatientModel.fromMap(patientInfo.toMap()));

      return result;
    } on ServerException {
      throw ServerFailure(message: 'An error has occured');
    } on SocketException {
      throw ConnectionFailure(message: 'Failed to connect to the network');
    }
  }
}
