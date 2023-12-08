// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/clinics/clinicsList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/doctors/doctorsList.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/serachMenu.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/specialityList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Containe extends StatefulWidget {
  const Containe({
    super.key,
  });

  @override
  State<Containe> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<Containe> {
  int selectedindex2 = 0;

  @override
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);

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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: "My Appointement"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite")
          ]),
      drawerEnableOpenDragGesture: false,
      body: ListView(
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
                  Align(
                    //  recommended clinics
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 11.w),
                      child: Text("Recommended clinics",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600)),
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
                          "Specialty",
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
                          "Search",
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
                        Text("Recommended doctors",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600)),
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
                          child: Text("See All",
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
      ),
    );
  }
}
