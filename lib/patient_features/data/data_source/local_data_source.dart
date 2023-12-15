// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dawini_full/patient_features/data/models/doctor_model.dart';
import 'package:dawini_full/patient_features/data/models/patient_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSourceDoctors {
  Future<List<PatientModel>> MyDoctorsAppointments();
  Future<String> SetAdoctorAppointment(PatientModel patient);
  Future<String> DeleteAdoctorAppointment(PatientModel patient);

  Future<String> SetAFavoriteDoctors(String doctorUid);
  Future<List<DoctorModel>> MyFavoriteDoctors();
}

class LocalDataSourceImpl extends LocalDataSourceDoctors {
  static final Future<SharedPreferences> prefs =
      SharedPreferences.getInstance();

  @override
  Future<List<PatientModel>> MyDoctorsAppointments() async {
    SharedPreferences pref = await prefs;
    String? patientsString = pref.getString('patients');
    if (patientsString == null) {
      return [];
    } else {
      var patientMapList = jsonDecode(patientsString) as List;
      return patientMapList
          .map((patientMap) => PatientModel.fromJson(patientMap))
          .toList();
    }
  }

  @override
  Future<String> SetAFavoriteDoctors(String doctorUid) async {
    SharedPreferences pref = await prefs;

    List<String>? favorite = pref.getStringList('FavoriteDoctros');
    try {
      favorite!.add(doctorUid);

      pref.setStringList("FavoriteDoctros", favorite);

      return 'Info Saving done';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }

  @override
  Future<String> SetAdoctorAppointment(PatientModel patient) async {
    try {
      String datetime =
          DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
      List<PatientModel> patients = await MyDoctorsAppointments();
      SharedPreferences pref = await prefs;
      if (patient.AppointmentDate != datetime) {
        patient.today = 'no';
      } else {
        patient.today = 'yes';
      }
      patients.add(patient);
      String patientsString = jsonEncode(patients
          .map((patient) => patient.toJson())
          .toList()); // Assuming you have a toJson method in your PatientEntity class
      pref.setString('patients', patientsString);

      return 'Info Saving done';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }

  @override
  Future<List<DoctorModel>> MyFavoriteDoctors() {
    throw UnimplementedError();
  }

  @override
  Future<String> DeleteAdoctorAppointment(PatientModel patient) async {
    try {
      SharedPreferences pref = await prefs;

      List<PatientModel> patients = await MyDoctorsAppointments();
      patients.remove(patient);
      String patientsString = jsonEncode(patients
          .map((patient) => patient.toJson())
          .toList()); // Assuming you have a toJson method in your PatientEntity class
      pref.setString('patients', patientsString);

      return 'patient removed';
    } catch (e) {
      throw 'error when saving info Try again please';
    }
  }
}
