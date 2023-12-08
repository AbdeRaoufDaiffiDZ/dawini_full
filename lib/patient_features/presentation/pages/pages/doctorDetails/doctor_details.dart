import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:flutter/material.dart';

class doctorDetails extends StatefulWidget {
  final String uid;
  const doctorDetails({super.key, required this.uid});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  @override
  Widget build(BuildContext context) {
    final uid = widget.uid;

    return StreamBuilder<List<DoctorEntity>>(
        stream: GetDoctorsStreamInfoUseCase.excute(),
        builder: (context, snapshot) {
          late final List<DoctorEntity> data;
          if (snapshot.data == null) {
            data = [];
          } else {
            if (snapshot.data!.isEmpty) {
              data = [];
            } else {
              data = snapshot.data!;
            }
          }
          List<DoctorEntity> doctors =
              data.where((element) => element.uid == uid).toList();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  children: [
                    Text(doctors.isNotEmpty ? doctors.first.firstName : ""),
                    Text(doctors.isNotEmpty ? doctors.first.lastName : ""),
                    Text(doctors.isNotEmpty
                        ? doctors.first.atSerivce.toString()
                        : ""),
                    Text(doctors.isNotEmpty ? doctors.first.speciality : ""),
                    Text(doctors.isNotEmpty ? doctors.first.phoneNumber : ""),
                    Text(
                        doctors.isNotEmpty ? doctors.first.turn.toString() : "")
                  ],
                ),
              ),
            ),
          );
        });
  }
}
