// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class doctorDetails extends StatefulWidget {
  final String uid;
  const doctorDetails({super.key, required this.uid});

  @override
  State<doctorDetails> createState() => _doctorDetailsState();
}

class _doctorDetailsState extends State<doctorDetails> {
  String datetime = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final uid = widget.uid;
    final PatientsBloc dataBloc = BlocProvider.of<PatientsBloc>(context);
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _lastNameController = TextEditingController();
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
                    Text(doctors.isNotEmpty
                        ? doctors.first.turn.toString()
                        : ""),
                    SizedBox(height: 3.w),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'firstName'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the patient\'s name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(labelText: 'Last Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the patient\'s Last Name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.w),
                    MaterialButton(
                      color: Colors.blueGrey,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          PatientEntity patient = PatientEntity(
                              AppointmentDate: datetime,
                              turn: 0,
                              doctorRemark: "doctorRemark",
                              address: "address",
                              firstName: _nameController.text,
                              lastName: _lastNameController.text,
                              phoneNumber: "phoneNumber",
                              today: '');
                          dataBloc.add(onPatientsSetAppointments(context,
                              patients: patient));
                        }
                      },
                      child: Text("Press ME"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
