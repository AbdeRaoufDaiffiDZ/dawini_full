import 'package:dawini_full/patient_features/domain/entities/doctor.dart';

class DoctorModel extends DoctorEntity {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  DoctorModel(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber})
      : super(
            firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);

  @override
  // TODO: implement props
  List<Object?> get props => [lastName, firstName, phoneNumber];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) {
    return DoctorModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  DoctorEntity toEntity() => DoctorEntity(
      firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
}
