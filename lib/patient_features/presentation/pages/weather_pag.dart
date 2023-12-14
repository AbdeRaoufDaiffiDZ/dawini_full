// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/clinics/clinicsList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/doctors/doctorsList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/serachMenu.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/specialityList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Containe extends StatefulWidget {
  const Containe({
    super.key,
  });

  @override
  State<Containe> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<Containe> {
  int selectedindex2 = 0;
  List<String> where = ["home", "appointments", "favorite"];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final PatientsBloc patientsdataBloc =
        BlocProvider.of<PatientsBloc>(context);

    AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 26,
            unselectedFontSize: 14,
            selectedFontSize: 17,
            currentIndex: selectedindex2,
            onTap: (value) {
              setState(() {
                selectedindex2 = value;
              });
            },
            elevation: 20,
            selectedItemColor: Color(0xFF2CDBC6),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: text.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: text.my_Appointement),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: text.favorite)
            ]),
        drawerEnableOpenDragGesture: false,
        body: whereIam(text, dataBloc, patientsdataBloc));
  }

  Widget whereIam(
      AppLocalizations text, DoctorBloc dataBloc, PatientsBloc patientsBloc) {
    switch (selectedindex2) {
      case 0:
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.all(1),
                color: Colors.white,
                child: Column(
                  children: [
                    SearchMenu(),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h, left: 11.w),
                      child: Row(
                        children: [
                          Text(text.recommended_clinics,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 110.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: Column(
                                        children: [
                                          SearchMenuClinics(),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          ClinicsList(),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Text(text.see_all,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2CDBC6))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                        //  CLinics card
                        child: ClinicsList()),
                    SizedBox(height: 16.h),
                    Row(
                      // Specaility search scroll
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.w),
                          child: Text(
                            text.specialty,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 200.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(),
                                    body: Center(child: Text("Specialities")),
                                  ),
                                ));
                          },
                          child: Text(
                            text.search,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2CDBC6)),
                          ),
                        ),
                      ],
                    ),
                    SpecialityList(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h, left: 11.w),
                      child: Row(
                        children: [
                          Text(text.recommended_doctors,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 70.w),
                          GestureDetector(
                            onTap: () {
                              dataBloc.add(onSeeAllDoctors());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: Column(
                                        children: [
                                          SearchMenu(),
                                          DoctorsList(),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Text(text.see_all,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2CDBC6))),
                          )
                        ],
                      ),
                    ),
                    Container(child: DoctorsList()),
                  ],
                ),
              ),
            ),
          ],
        );
      case 1:
        return BlocBuilder<PatientsBloc, PatientsState>(
            builder: (context, state) {
          if (state is PatientsLoading) {
            return Loading();
          } else if (state is PatientsLoaded) {
            return ListView.builder(
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(state.patients[index].firstName),
                    subtitle: Text(state.patients[index].AppointmentDate),
                    trailing: GestureDetector(
                      child: Icon(Icons.delete),
                      onLongPress: () {
                        patientsBloc.add(onPatientsAppointmentDelete(context,
                            patients: state.patients[index]));
                            //////////////////////////////////////////////
                            kkkkkkkkkkkkkkkkkkkkkkkk
                      },
                    ));
              },
            );
          } else if (state is PatientsLoadingError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("fiald loading the data"),
              backgroundColor: Colors.red,
            ));
            return Loading();
          } else {
            return Loading();
          }
        });
      case 2:
        return Container();
      default:
        return Container();
    }
  }
}
