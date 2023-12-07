part of 'clinics_bloc.dart';

sealed class ClinicsState extends Equatable {
  const ClinicsState();

  @override
  List<Object> get props => [];
}

final class ClinicsInitial extends ClinicsState {}

final class ClinicLoading extends ClinicsState {}

final class ClinicLoaded extends ClinicsState {
  final List<ClinicEntity> clinic;
  final event;

  ClinicLoaded({required this.event, required this.clinic});

  @override
  List<Object> get props => [clinic];
}

final class ChossenClinic extends ClinicsState {
  final ClinicEntity clinic;

  ChossenClinic({required this.clinic});

  @override
  List<Object> get props => [clinic];
}

final class ClinicLoadingFailure extends ClinicsState {
  final String message;

  ClinicLoadingFailure({required this.message});

  @override
  List<Object> get props => [message];
}
