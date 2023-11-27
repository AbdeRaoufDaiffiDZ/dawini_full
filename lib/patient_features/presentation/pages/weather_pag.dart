// ignore_for_file: prefer_const_constructors

import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/pages/side_menu.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/serachMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorPage extends StatefulWidget {
  final Size device_size;
  DoctorPage({super.key, required this.device_size});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("DAWINI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.all(1),
          color: Colors.white,
          child: Column(
            children: [
              SearchMenu(), //////////  Search menu by name and by wilaya
              Expanded(
                child: BlocBuilder<DoctorBloc, DoctorState>(
                    builder: (context, state) {
                  if (state is DoctorLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ChossenDoctor) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("HERE"),
                      ),
                    );
                  }
                  if (state is DoctorLoaded) {
                    final doctors = state.doctor;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Material(
                              child: ListView.builder(
                                itemCount: doctors.length,
                                itemBuilder: (context, index) {
                                  final doctor = doctors[index];

                                  // Customize the DoctorEntity widget as needed
                                  return ListTile(
                                    onTap: () {
                                      context
                                          .read<DoctorBloc>()
                                          .add(onDoctorChoose(doctor: doctor));
                                    },
                                    title: Text(doctor.firstName),
                                    subtitle: Text(doctor.wilaya),
                                    // Add more fields as needed
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is DoctorLoadingFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
