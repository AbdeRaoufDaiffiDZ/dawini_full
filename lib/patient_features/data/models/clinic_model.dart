import 'package:dawini_full/patient_features/domain/entities/clinic.dart';

class ClinicModel extends ClinicEntity {
  final String ClinicName;
  final String phoneNumber;
  final String wilaya;
  final String city;
  final bool atSerivce;

  ClinicModel(
      {required this.ClinicName,
      required this.city,
      required this.atSerivce,
      required this.wilaya,
      required this.phoneNumber})
      : super(
            ClinicName: ClinicName,
            city: city,
            atSerivce: atSerivce,
            phoneNumber: phoneNumber,
            wilaya: wilaya);

  @override
  // TODO: implement props
  List<Object?> get props => [ClinicName, city, atSerivce, wilaya, phoneNumber];

  Map<String, dynamic> toMap() {
    return {
      'ClinicName': ClinicName,
      'phoneNumber': phoneNumber,
      'atSerivce': atSerivce,
      'city': city,
      'wilaya': wilaya
    };
  }

  factory ClinicModel.fromJson(Map<dynamic, dynamic> json) {
    return ClinicModel(
      ClinicName: json['clinicName'],
      phoneNumber: json['phoneNumber'],
      wilaya: json['Wilaya'],
      city: json[
          'Wilaya'], //////////////////////////////////   city must be add to databse
      atSerivce: json[
          'atSerivce'], ///////////////////////////////////////   atService must be add to database
    );
  }

  ClinicEntity toEntity() => ClinicEntity(
      ClinicName: ClinicName,
      phoneNumber: phoneNumber,
      wilaya: wilaya,
      city: city,
      atSerivce: atSerivce);
}
