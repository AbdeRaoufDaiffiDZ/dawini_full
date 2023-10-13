// ignore_for_file: void_checks

import 'dart:async';

import 'package:bloc/bloc.dart';
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
  final GetDoctorsStreamInfoUseCase streamDoctors;
  late final StreamSubscription<List<DoctorEntity>> streamSubscription;
  DoctorBloc(
    this.streamDoctors,
  ) : super(DoctorLoading()) {
    streamSubscription = streamDoctors.excute().listen((event) {
      add(doctorsInfoUpdated(doctors: event));
    });
    on<DoctorEvent>((event, emit) {
      emit(DoctorLoading());
      if (event is doctorsInfoUpdated) {
        emit(DoctorLoaded(doctor: event.doctors));
      }
      if (event is onDoctorChoose) {
        emit(ChossenDoctor(doctor: event.doctor));
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
