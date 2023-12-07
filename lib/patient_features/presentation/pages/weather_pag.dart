// ignore_for_file: prefer_const_constructors

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/pages/doctorDetails/doctor_details.dart';
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
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("DAWINI"),
      ),
      body: BlocListener<DoctorBloc, DoctorState>(
        listener: (context, state) {
          // Perform actions based on the state
          if (state is DoctorLoadingFailure) {
            // Show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ChossenDoctor) {
            // Navigate to another screen :
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => doctorDetails(doctor: state.doctor)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.all(1),
            color: Colors.white,
            child: Column(
              children: [
                SearchMenu(), //////////  Search menu by name and by wilaya
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<ClinicsBloc, ClinicsState>(
                        builder: (context, state) {
                      if (state is ClinicLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ClinicLoaded) {
                        final clinics = state.clinic;

                        return ClinicsLoadedScrees(
                            clinics, widget.device_size); /////////////
                      } else if (state is ClinicLoadingFailure) {
                        return ErrorWidget(state.message);
                      } else {
                        context.read<ClinicsBloc>().add(ClinicinitialEvent());
                        return Container();
                      }
                    }),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<DoctorBloc, DoctorState>(
                        builder: (context, state) {
                      if (state is DoctorLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is DoctorLoaded) {
                        final doctors = state.doctor;

                        return DoctorsLoadedScrees(doctors);
                      } else if (state is DoctorLoadingFailure) {
                        return ErrorWidget(state.message);
                      } else {
                        context.read<DoctorBloc>().add(DoctorinitialEvent());
                        return Container();
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget DoctorsLoadedScrees(List<DoctorEntity> doctors) {
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
                    context.read<DoctorBloc>().add(onDoctorChoose(
                          doctor: doctor,
                        ));
                  },
                  title: Text(doctor.firstName),
                  subtitle: Text(doctor.wilaya),
                  leading: Text(doctor.turn.toString()),

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

Widget ClinicsLoadedScrees(List<ClinicEntity> clinics, Size size) {
  return Container(
    color: Colors.amber,
    width: size.width,
    height: 100,
    child: Material(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          final clinic = clinics[index];

          // Customize the DoctorEntity widget as needed
          return Container(
            color: Colors.green,
            width: 150,
            child: ListTile(
              onTap: () {
                context
                    .read<ClinicsBloc>()
                    .add(onClinicChoose(clinics: clinic));
              },
              title: Text(clinic.ClinicName),
              subtitle: Text(clinic.wilaya),
              // Add more fields as needed
            ),
          );
        },
      ),
    ),
  );
}
