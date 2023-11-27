import 'package:dawini_full/patient_features/domain/entities/doctor.dart';

class DoctorModel extends DoctorEntity {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;

  DoctorModel(
      {required this.wilaya,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber})
      : super(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            wilaya: wilaya);

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
      wilaya: json['Wilaya'],
    );
  }

  DoctorEntity toEntity() => DoctorEntity(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      wilaya: wilaya);
}
