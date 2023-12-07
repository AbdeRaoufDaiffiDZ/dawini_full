import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class doctorDetails extends StatefulWidget {
  final DoctorEntity doctor;
  const doctorDetails({super.key, required this.doctor});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(builder: (context, state) {
      if (state is DoctorLoaded) {
        final doctor = state.doctor.first;

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  Text(doctor.firstName),
                  Text(doctor.lastName),
                  Text(doctor.atSerivce.toString()),
                  Text(doctor.speciality),
                  Text(doctor.phoneNumber),
                  Text(doctor.turn.toString())
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          child: Text(state.toString()),
        );
      }
    });
  }
}
