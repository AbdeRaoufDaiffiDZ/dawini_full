import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctors_data_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityList extends StatefulWidget {
  const SpecialityList({super.key});

  @override
  State<SpecialityList> createState() => _SpecialityListState();
}

class _SpecialityListState extends State<SpecialityList> {
  final List<Map<String, String>> mylist = [
    {"text": "ALL", "icon": "assets/images/generalist.png"},
    {"text": "Generalist", "icon": "assets/images/generalist.png"},
    {"text": "Dentist", "icon": "assets/images/dentist.png"},
    {"text": "Opthalm", "icon": "assets/images/opthalm.png"},
    {"text": "Endocrino", "icon": "assets/images/endocrino.png"},
    {"text": "Cardiology", "icon": "assets/images/cardiology.png"},
  ];
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);

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
          return Container(
            height: 100.h,
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: GestureDetector(
                          child: Image.asset(mylist[index]["icon"] as String),
                          onTap: () {
                            dataBloc.add(onDoctorsearchByspeciality(
                                doctors: data,
                                speciality: (mylist[index]["text"] as String)
                                    .toLowerCase()));
                          },
                        ),
                      ),
                      Text(
                        mylist[index]["text"] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }
}
