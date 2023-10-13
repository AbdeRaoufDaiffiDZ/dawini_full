import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  DoctorEntity(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [lastName, firstName, phoneNumber];
}
