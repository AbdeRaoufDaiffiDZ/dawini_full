import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String doctorRemark;
  final String AppointmentDate;
  final int turn;
  final String today;
  PatientEntity(
      {required this.today,
      required this.AppointmentDate,
      required this.turn,
      required this.doctorRemark,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [
        today,
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
      'today': today
    };
  }
}
