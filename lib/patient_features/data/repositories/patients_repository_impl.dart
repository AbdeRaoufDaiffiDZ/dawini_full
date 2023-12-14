// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/data_source/local_data_source.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/patients_repository.dart';

class PatientRepositoryImpl implements PatientsRepository {
  static final LocalDataSourceDoctors localDataSourcePatients =
      LocalDataSourceImpl();

  @override
  Future<Either<Failure, List<DoctorEntity>>> getFavoriteDoctors() async {
    try {
      final result = await localDataSourcePatients.MyFavoriteDoctors();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PatientEntity>>> GetAdoctorAppointment() async {
    try {
      final result = await localDataSourcePatients.MyDoctorsAppointments();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> SetAdoctorAppointment(
      PatientEntity patient) async {
    try {
      final result = await localDataSourcePatients.SetAdoctorAppointment(
          PatientModel.fromMap(patient.toMap()));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PatientEntity>>> SetFavoriteDoctor(
      DoctorEntity doctor) {
    // TODO: implement SetFavoriteDoctor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> DeleteAdoctorAppointment(
      PatientEntity patient) async {
    try {
      final result = await localDataSourcePatients.DeleteAdoctorAppointment(
          PatientModel.fromMap(patient.toMap()));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(message: 'An error has occured'));
    } on SocketException {
      return Left(
          ConnectionFailure(message: 'Failed to connect to the network'));
    }
  }
}
