import 'package:dawini_full/patient_features/domain/entities/doctor.dart';

class DoctorModel extends DoctorEntity {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final String speciality;
  final bool atSerivce;
  final int turn;
  final String uid;

  DoctorModel(
      {required this.uid,
      required this.city,
      required this.turn,
      required this.speciality,
      required this.atSerivce,
      required this.wilaya,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber})
      : super(
            uid: uid,
            turn: turn,
            city: city,
            speciality: speciality,
            atSerivce: atSerivce,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            wilaya: wilaya);

  @override
  // TODO: implement props
  List<Object?> get props => [
        lastName,
        firstName,
        phoneNumber,
        turn,
        speciality,
        atSerivce,
        wilaya,
        city,
        uid
      ];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'atSerivce': atSerivce,
      'speciality': speciality,
      'city': city,
      'turn': turn,
      'uid': uid
    };
  }

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) {
    return DoctorModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        wilaya: json['Wilaya'],
        city: json[
            'city'], //////////////////////////////////   city must be add to databse
        speciality: json['speciality'],
        atSerivce: json[
            'atSerivce'], ///////////////////////////////////////   atService must be add to database
        turn: json['turn'],
        uid: json['uid']);
  }

  DoctorEntity toEntity() => DoctorEntity(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      wilaya: wilaya,
      city: city,
      speciality: speciality,
      atSerivce: atSerivce,
      turn: turn);
}
