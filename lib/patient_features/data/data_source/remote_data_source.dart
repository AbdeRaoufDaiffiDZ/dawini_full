import 'dart:convert';

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/core/error/exception.dart';
import 'package:dawini_full/patient_features/data/models/clinic_model.dart';
import 'package:dawini_full/patient_features/data/models/doctor_model.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getDoctorsInfo();
  Stream<List<DoctorEntity>> streamDoctors();
  Future<UserCredential> authDoctor(email, password);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final http.Client client;
  final FirebaseDatabase _databaseReference;
  final FirebaseAuth auth;

  DoctorRemoteDataSourceImpl(
    this.client,
    this._databaseReference,
    this.auth,
  );
  @override
  Future<List<DoctorModel>> getDoctorsInfo() async {
    final response = await client.get(Uri.parse(Urls.doctorInfoUrl()));
    if (response.statusCode == 200) {
      List<DoctorModel> users =
          (json.decode(response.body) as List).map((data) {
        return DoctorModel.fromJson(data);
      }).toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  Stream<List<DoctorModel>> streamDoctors() {
    List<DoctorModel> resulted = [];
    final result =
        _databaseReference.ref().child('doctorsList').onValue.map((event) {
      resulted.clear();

      List currapted = event.snapshot.value as List;
      final data = currapted.map((e) {
        return DoctorModel.fromJson(e);
      }).toList();

      return data;
    });
    return result;
  }

  @override
  Future<UserCredential> authDoctor(email, password) async {
    final response =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }
}

abstract class ClinicsRemoteDataSource {
  Future<List<ClinicModel>> getClincsInfo();
  Stream<List<ClinicEntity>> streamClincss();
  Future<UserCredential> authClinic(email, password);
}

class ClinicsRemoteDataSourceImpl implements ClinicsRemoteDataSource {
  final http.Client client;
  final FirebaseDatabase _databaseReference;
  final FirebaseAuth auth;

  ClinicsRemoteDataSourceImpl(
    this.client,
    this._databaseReference,
    this.auth,
  );
  @override
  Future<List<ClinicModel>> getClincsInfo() async {
    final response = await client.get(Uri.parse(Urls.doctorInfoUrl()));
    if (response.statusCode == 200) {
      List<ClinicModel> users =
          (json.decode(response.body) as List).map((data) {
        return ClinicModel.fromJson(data);
      }).toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  Stream<List<ClinicModel>> streamClincss() {
    List<ClinicModel> resulted = [];
    final result =
        _databaseReference.ref().child('doctorsList').onValue.map((event) {
      resulted.clear();

      List currapted = event.snapshot.value as List;
      final data = currapted.map((e) {
        return ClinicModel.fromJson(e);
      }).toList();

      return data;
    });
    return result;
  }

  @override
  Future<UserCredential> authClinic(email, password) async {
    final response =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }
}
