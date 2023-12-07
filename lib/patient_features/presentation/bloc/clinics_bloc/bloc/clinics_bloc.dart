import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_clinics_info.dart';
import 'package:equatable/equatable.dart';

part 'clinics_event.dart';
part 'clinics_state.dart';

class ClinicsBloc extends Bloc<ClinicsEvent, ClinicsState> {
  final GetClinicsInfoUseCase getClinicsInfoUseCase;
  final GetClinicsStreamInfoUseCase streamClinics;
  late final StreamSubscription<List<ClinicEntity>> streamClinicSubscription;
  ClinicsBloc(
    this.streamClinics,
    this.getClinicsInfoUseCase,
  ) : super(ClinicLoading()) {
    late List<ClinicEntity> info;

    streamClinicSubscription = streamClinics.excute().listen((event) {
      add(ClinicInfoUpdated(clinics: event));
      info = event;
    });
    on<ClinicsEvent>((event, emit) async {
      emit(ClinicLoading());
      if (event is ClinicInfoUpdated) {
        emit(ClinicLoaded(clinic: event.clinics, event: event));
      } else if (event is onClinicChoose) {
        emit(ChossenClinic(clinic: event.clinics));
      } else if (event is onClinicsearchByName) {
        List<ClinicEntity> clinic;
        // List<ClinicEntity> info;
        // info = await getClinicsInfoUseCase.excute();

        if (event.clinicName.isEmpty) {
          clinic = info;
        } else {
          clinic = info
              .where((element) => element.ClinicName.toLowerCase()
                  .contains(event.clinicName.toLowerCase()))
              .toList();
        }

        emit(ClinicLoaded(clinic: clinic, event: event.clinicName));
      } else if (event is onClinicsearchByWilaya) {
        List<ClinicEntity> clinic;
        // List<ClinicEntity> info;
        // info = await getClinicsInfoUseCase.excute();

        if (event.wilaya.isEmpty || event.wilaya == 'all') {
          clinic = info;
        } else {
          clinic = info
              .where((element) => element.wilaya
                  .toLowerCase()
                  .contains(event.wilaya.toLowerCase()))
              .toList();
        }

        emit(ClinicLoaded(clinic: clinic, event: event));
      } else if (event is ClinicinitialEvent) {
        streamClinics.excute().listen((event) {
          add(ClinicInfoUpdated(clinics: event));
        });
      }
    });
  }
  @override
  Future<void> close() {
    streamClinicSubscription.cancel();
    return super.close();
  }
}
