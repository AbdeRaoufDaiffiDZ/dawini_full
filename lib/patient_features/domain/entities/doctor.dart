import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String wilaya;

  DoctorEntity(
      {required this.wilaya,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [lastName, firstName, phoneNumber];
}
