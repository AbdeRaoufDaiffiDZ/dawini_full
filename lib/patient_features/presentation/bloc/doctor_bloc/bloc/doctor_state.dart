part of 'doctor_bloc.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorLoaded extends DoctorState {
  final List<DoctorEntity> doctor;

  DoctorLoaded({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

final class ChossenDoctor extends DoctorState {
  final DoctorEntity doctor;

  ChossenDoctor({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

final class DoctorLoadingFailure extends DoctorState {
  final String message;

  DoctorLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SeeAllDoctors extends DoctorState {
  final List<DoctorEntity> doctor;

  SeeAllDoctors({required this.doctor});

  @override
  List<Object> get props => [doctor];
}
