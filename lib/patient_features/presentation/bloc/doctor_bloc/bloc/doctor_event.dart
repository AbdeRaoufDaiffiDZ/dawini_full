part of 'doctor_bloc.dart';

sealed class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class onDoctorChoose extends DoctorEvent {
  final DoctorEntity doctor;

  onDoctorChoose({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

class doctorsInfoUpdated extends DoctorEvent {
  final List<DoctorEntity> doctors;

  const doctorsInfoUpdated({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class onDoctorsearchByName extends DoctorEvent {
  final String doctorName;

  onDoctorsearchByName({required this.doctorName});

  @override
  List<Object> get props => [doctorName];
}

class onDoctorsearchByWilaya extends DoctorEvent {
  final String wilaya;

  onDoctorsearchByWilaya({required this.wilaya});

  @override
  List<Object> get props => [wilaya];
}

class DoctorinitialEvent extends DoctorEvent {}
