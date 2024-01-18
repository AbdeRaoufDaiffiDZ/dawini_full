import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/usecases/appointments_local_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctors_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final GetAppointmentLocalusecase getAppointmentLocalusecase;
  final SetDoctorAppointmentusecase setAppointmentLocalusecase;
  final DeletAppointmentLocalusecase deletAppointmentLocalusecase;
  final BookDoctorAppointmentUseCase bookDoctorAppointmentUseCase;
  PatientsBloc(this.getAppointmentLocalusecase, this.setAppointmentLocalusecase,
      this.deletAppointmentLocalusecase, this.bookDoctorAppointmentUseCase)
      : super(PatientsLoading()) {
    on<PatientsEvent>((event, emit) async {
      emit(PatientsLoading());
      if (event is PatientsinitialEvent) {
        try {
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsReload) {
        try {
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoaded(patients));
        } catch (e) {
          emit(PatientsLoadingError(e.toString()));
        }
      }

      // else if (event is onPatientsInfoUpdated) {
      //   try {
      //     setAppointmentLocalusecase.excute(event.patients);
      //   } catch (e) {
      //     emit(PatientsLoadingError(e.toString()));
      //   }
      // }
      else if (event is onPatientsSetAppointments) {
        try {
          final done =
              await bookDoctorAppointmentUseCase.excute(event.patients);
          if (done) {
            ScaffoldMessenger.of(event.context).showSnackBar(
                SnackBar(content: Text("done"), backgroundColor: Colors.green));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: Text("try again"), backgroundColor: Colors.red));
          }
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      } else if (event is onPatientsAppointmentDelete) {
        try {
          final result =
              await deletAppointmentLocalusecase.excute(event.patients);
          result.fold(
              (l) => ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                  content: Text(l.message), backgroundColor: Colors.red)),
              (r) => ScaffoldMessenger.of(event.context).showSnackBar(
                  SnackBar(content: Text(r), backgroundColor: Colors.green)));
          final List<PatientEntity> patients =
              await getAppointmentLocalusecase.excute();
          emit(PatientsLoading());
          emit(PatientsLoaded(patients));
        } catch (e) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text("try again"), backgroundColor: Colors.red));
          emit(PatientsLoadingError(e.toString()));
        }
      }
    });
  }
}
