import 'dart:convert';

import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String doctorRemark;
  final String AppointmentDate;
  final int turn;

  PatientEntity(
      {required this.AppointmentDate,
      required this.turn,
      required this.doctorRemark,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [
        lastName,
        firstName,
        phoneNumber,
        address,
        doctorRemark,
        AppointmentDate,
        turn,
      ];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'doctorRemark': doctorRemark,
      'AppointmentDate': AppointmentDate,
      'turn': turn,
    };
  }

  factory PatientEntity.fromMap(Map<String, dynamic> map) {
    return PatientEntity(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      doctorRemark: map['doctorRemark'] ?? '',
      AppointmentDate: map['AppointmentDate'] ?? '',
      turn: map['turn']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientEntity.fromJson(String source) =>
      PatientEntity.fromMap(json.decode(source));
}
