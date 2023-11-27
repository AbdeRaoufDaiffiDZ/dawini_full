// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorsInfoUseCase getDoctorsInfoUseCase;
  final GetDoctorsStreamInfoUseCase streamDoctors;
  late final StreamSubscription<List<DoctorEntity>> streamSubscription;
  DoctorBloc(
    this.streamDoctors,
    this.getDoctorsInfoUseCase,
  ) : super(DoctorLoading()) {
    streamSubscription = streamDoctors.excute().listen((event) {
      add(doctorsInfoUpdated(doctors: event));
    });
    on<DoctorEvent>((event, emit) async {
      emit(DoctorLoading());
      if (event is doctorsInfoUpdated) {
        emit(DoctorLoaded(doctor: event.doctors));
      }
      if (event is onDoctorChoose) {
        emit(ChossenDoctor(doctor: event.doctor));
      }
      if (event is onDoctorsearchByName) {
        List<DoctorEntity> doctors;
        List<DoctorEntity> info;
        info = await getDoctorsInfoUseCase.excute();

        if (event.doctorName.isEmpty) {
          doctors = info;
        } else {
          doctors = info
              .where((element) => element.lastName
                  .toLowerCase()
                  .contains(event.doctorName.toLowerCase()))
              .toList();
        }

        emit(DoctorLoaded(doctor: doctors));
      }
      if (event is onDoctorsearchByWilaya) {
        List<DoctorEntity> doctors;
        List<DoctorEntity> info;
        info = await getDoctorsInfoUseCase.excute();

        if (event.wilaya.isEmpty || event.wilaya == 'all') {
          doctors = info;
        } else {
          doctors = info
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(event.wilaya.toLowerCase()))
              .toList();
        }

        emit(DoctorLoaded(doctor: doctors));
      }
    });
  }
  // Future<void> clear() {
  //   DoctorLoaded doctorLoaded = DoctorLoaded(doctor: );
  // }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
