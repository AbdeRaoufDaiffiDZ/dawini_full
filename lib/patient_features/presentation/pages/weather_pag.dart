// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctors_data_usecase.dart';
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
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
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
                return Container(
                  margin: EdgeInsets.only(
                      left: 6.w, right: 6.w, top: 14.h, bottom: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 212, 212, 212), // Set the border color
                      width: 2.w, // Set the border width
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              "Dr. " + state.patients[index].DoctorName,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              state.patients[index].firstName +
                                  " " +
                                  state.patients[index].lastName,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 200.w,
                            margin: EdgeInsets.only(
                                left: 6.w, right: 6.w, top: 15.h, bottom: 14.h),
                            child: MaterialButton(
                              elevation: 0,
                              onLongPress: () {
                                patientsBloc.add(onPatientsAppointmentDelete(
                                    context,
                                    patients: state.patients[index]));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color.fromARGB(54, 177, 177, 177),
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  "cancel appointment ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Column(
                        children: [
                          Container(
                            child: StreamBuilder<List<DoctorEntity>>(
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
                                  List<DoctorEntity> doctors = data
                                      .where((element) =>
                                          element.uid ==
                                          state.patients[index].uid)
                                      .toList();
                                  if (!doctors.isEmpty) {
                                    if (state.patients[index].turn - 2 ==
                                        (doctors.first.turn)) {
                                      NotificationShower(
                                          state.patients[index].firstName +
                                              " " +
                                              state.patients[index].lastName,
                                          index,
                                          "Dr. " + doctors.first.lastName,
                                          "is near");
                                    } else if (state.patients[index].turn - 1 ==
                                        (doctors.first.turn)) {
                                      NotificationShower(
                                          state.patients[index].firstName +
                                              " " +
                                              state.patients[index].lastName,
                                          index,
                                          "Dr. " + doctors.first.lastName,
                                          "is after one Patient");
                                    } else if (state.patients[index].turn ==
                                        (doctors.first.turn)) {
                                      NotificationShower(
                                          state.patients[index].firstName +
                                              " " +
                                              state.patients[index].lastName,
                                          index,
                                          "Dr. " + doctors.first.lastName,
                                          "is NOW");
                                    }
                                  }
                                  return Center(
                                      child: Text(
                                    !doctors.isEmpty
                                        ? doctors.first.turn.toString()
                                        : "",
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ));
                                }),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromARGB(38, 158, 158, 158),
                              border: Border.all(
                                color: Color.fromARGB(
                                    0, 158, 158, 158), // Set the border color
                                width: 3.w, // Set the border width
                              ),
                            ),
                            width: 70.w,
                            height: 60.h,
                          ),
                          Text(
                              "current turn\n is at: ${state.patients[index].turn} ")
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PatientsLoadingError) {
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

  NotificationShower(String patientName, int index, String doctorName, body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: index,
            channelKey: 'basic_channel',
            title: "your turn ${body}",
            body: "${patientName} turn at ${doctorName} ${body}"));
  }
}
