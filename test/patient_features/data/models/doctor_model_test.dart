import 'dart:convert';

import 'package:dawini_full/patient_features/data/models/doctor_model.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/json_reader.dart';

void main() {
  var testDoctorEntityDetails = DoctorModel(
      firstName: 'Dawini', lastName: 'App', phoneNumber: '0674282928');
  test('should be a subclass of doctor entity', () async {
    //assert
    expect(testDoctorEntityDetails, isA<DoctorEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers\\dummy_data\\dummy_doctor_respense.json'),
    );
    //act
    final result = DoctorModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testDoctorEntityDetails));
  });
}
