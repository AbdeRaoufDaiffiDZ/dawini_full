import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

class doctorDetails extends StatefulWidget {
  final DoctorEntity doctor;
  const doctorDetails({super.key, required this.doctor});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

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
              Text(doctor.phoneNumber)
            ],
          ),
        ),
      ),
    );
  }
}
