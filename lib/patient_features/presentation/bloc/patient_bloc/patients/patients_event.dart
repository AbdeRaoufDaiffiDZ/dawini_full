// ignore_for_file: camel_case_types

part of 'patients_bloc.dart';

sealed class PatientsEvent extends Equatable {
  const PatientsEvent();
  @override
  List<Object> get props => [];
}

class PatientsinitialEvent extends PatientsEvent {}

class onPatientsInfoUpdated extends PatientsEvent {
  final PatientEntity patients;

  const onPatientsInfoUpdated({required this.patients});

  @override
  List<Object> get props => [patients];
}

class onPatientsReload extends PatientsEvent {}

class onPatientsSetAppointments extends PatientsEvent {
  final PatientEntity patients;
  final BuildContext context;

  const onPatientsSetAppointments(this.context, {required this.patients});

  @override
  List<Object> get props => [patients, context];
}

class onPatientsAppointmentDelete extends PatientsEvent {
  final PatientEntity patients;
  final BuildContext context;

  const onPatientsAppointmentDelete(this.context, {required this.patients});

  @override
  List<Object> get props => [patients, context];
}
