// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    late List<DoctorEntity> info;
    on<DoctorinitialEvent>((event, emit) async {
      final data = getDoctorsInfoUseCase.excute();

      add(doctorsInfoUpdated(doctors: await data));
    });
    streamSubscription = streamDoctors.excute().listen((data) {
      info = data;

      on<doctorsInfoUpdated>((event, emit) async {
        emit(DoctorLoaded(
          doctor: event.doctors,
        ));
      });
      on<onDoctorsearchByspeciality>((event, emit) async {
        List<DoctorEntity> doctors;

        // List<DoctorEntity> info;
        // info = await getDoctorsInfoUseCase.excute();

        if (event.speciality.isEmpty || event.speciality == 'all') {
          doctors = info;
        } else {
          doctors = info
              .where((element) => element.speciality
                  .toLowerCase()
                  .contains(event.speciality.toLowerCase()))
              .toList();
        }

        emit(DoctorLoaded(doctor: doctors));
      });

      //   on<DoctorEvent>((event, emit) async {
      //     emit(DoctorLoading());
      //     if (event is doctorsInfoUpdated) {
      //       emit(DoctorLoaded(
      //         doctor: event.doctors,
      //       ));
      //     } else if (event is onDoctorChoose) {
      //       emit(ChossenDoctor(doctor: event.doctor));
      //     } else if (event is onDoctorsearchByName) {
      //       List<DoctorEntity> doctors;
      //       // List<DoctorEntity> info;
      //       // info = await getDoctorsInfoUseCase.excute();
      //       streamSubscription = streamDoctors.excute().listen((data) {
      //         info = data;
      //       });
      //       if (event.doctorName.isEmpty) {
      //         doctors = info;
      //       } else {
      //         doctors = info
      //             .where((element) => element.lastName
      //                 .toLowerCase()
      //                 .contains(event.doctorName.toLowerCase()))
      //             .toList();
      //         if (doctors.isEmpty) {
      //           doctors = info
      //               .where((element) => element.firstName
      //                   .toLowerCase()
      //                   .contains(event.doctorName.toLowerCase()))
      //               .toList();
      //         }
      //       }

      //       emit(DoctorLoaded(
      //         doctor: doctors,
      //       ));
      //     } else if (event is onDoctorsearchByWilaya) {
      //       List<DoctorEntity> doctors;
      //       // List<DoctorEntity> info;
      //       // info = await getDoctorsInfoUseCase.excute();

      //       if (event.wilaya.isEmpty || event.wilaya == 'province') {
      //         doctors = info;
      //       } else {
      //         doctors = info
      //             .where((element) => element.wilaya
      //                 .toLowerCase()
      //                 .contains(event.wilaya.toLowerCase()))
      //             .toList();
      //       }

      //       emit(DoctorLoaded(doctor: doctors));
      //     } else if (event is DoctorinitialEvent) {
      //       final data = getDoctorsInfoUseCase.excute();
      //       // streamDoctors.excute().listen((event) {
      //       //   add(doctorsInfoUpdated(doctors: event));
      //       // });
      //       add(doctorsInfoUpdated(doctors: await data));
      //     } else if (event is onSeeAllDoctors) {
      //       // List<DoctorEntity> doctors;

      //       // streamDoctors.excute().listen((event) {
      //       //   doctors = event;
      //       // });
      //       emit(DoctorLoaded(doctor: info));
      //     }
      //     //   else if (event is onDoctorsearchByspeciality) {
      //     //     List<DoctorEntity> doctors;

      //     //     // List<DoctorEntity> info;
      //     //     // info = await getDoctorsInfoUseCase.excute();

      //     //     if (event.speciality.isEmpty || event.speciality == 'all') {
      //     //       doctors = info;
      //     //     } else {
      //     //       doctors = info
      //     //           .where((element) => element.speciality
      //     //               .toLowerCase()
      //     //               .contains(event.speciality.toLowerCase()))
      //     //           .toList();
      //     //     }

      //     //     emit(DoctorLoaded(doctor: doctors));
      //     //   }
      //   });
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
