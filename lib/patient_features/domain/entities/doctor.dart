import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final int turn;

  DoctorEntity(
      {required this.uid,
      required this.city,
      required this.turn,
      required this.speciality,
      required this.atSerivce,
      required this.wilaya,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [
        lastName,
        firstName,
        phoneNumber,
        speciality,
        city,
        atSerivce,
        wilaya,
        turn,
        uid
      ];
}
