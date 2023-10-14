// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:equatable/equatable.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

// class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
//   final GetDoctorsStreamInfoUseCase getDoctorsStreamInfoUseCase;
//   DoctorBloc(this.getDoctorsStreamInfoUseCase) : super(DoctorInitial()) {
//     on<DoctorEvent>((event, emit) async {
//       if (event is onDoctorSearch) {
//         emit(DoctorLoading());
//         final result = await getDoctorsStreamInfoUseCase.excute();
//         result.fold((l) => emit(DoctorLoadingFailure(message: l.message)),
//             (r) => emit(DoctorLoaded(doctor: r)));
//       }
//     }, transformer: debounce(const Duration(milliseconds: 500)));
//   }
// }

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
