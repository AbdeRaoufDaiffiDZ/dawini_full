import 'dart:convert';

import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSourceDoctors {
  Future<List<PatientEntity>> MyDoctorsAppointments();
  Future<String> SetAdoctorAppointment(
      PatientEntity patientEntity, String uid, String doctorName);
  Future<String> SetAFavoriteDoctors(String doctorUid);
  Future<List<String>> MyFavoriteDoctors();
}

class LocalDataSourceImpl extends LocalDataSourceDoctors {
  final SharedPreferences prefs;

  LocalDataSourceImpl({required this.prefs});

  @override
  Stream<String> getType() async* {
    final String? status = prefs.getString('type');
    if (status == null) {
      yield 'noon';
    } else {
      yield status;
    }
  }

  @override
  Future<List<PatientEntity>> MyDoctorsAppointments() async {
    String? patientsString = prefs.getString('MyAppointments');
    var patientMapList = jsonDecode(patientsString!) as List;
    return patientMapList
        .map((patientMap) => PatientEntity.fromJson(patientMap))
        .toList(); //
  }

  @override
  Future<List<String>> MyFavoriteDoctors() async {
    // TODO: implement MyDoctorsAppointments
    throw UnimplementedError();
  }

  @override
  Future<String> SetAFavoriteDoctors(String doctorUid) async {
    List<String>? favorite = prefs.getStringList('FavoriteDoctros');
    try {
      favorite!.add(doctorUid);

      prefs.setStringList("FavoriteDoctros", favorite);

      return await 'Info Saving done';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }

  @override
  Future<String> SetAdoctorAppointment(
      PatientEntity patientEntity, String uid, String doctorName) async {
    try {
      List<PatientEntity> patients = await MyDoctorsAppointments();
      patients.add(patientEntity);
      String patientsString = jsonEncode(patients
          .map((patient) => patient.toJson())
          .toList()); // Assuming you have a toJson method in your PatientEntity class
      prefs.setString('patients', patientsString);

      return await 'Info Saving done';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }
}
