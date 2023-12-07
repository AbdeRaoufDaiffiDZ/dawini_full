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
  final mylist = [
    {"text": "ALL", "icon": Icons.all_out},
    {"text": "Generalist", "icon": Icons.home},
    {"text": "Dentist", "icon": Icons.work},
    {"text": "Ophtahlam", "icon": Icons.school},
    {"text": "azheme", "icon": Icons.access_alarms_sharp},
    {"text": "Endocrino", "icon": Icons.access_time_filled_rounded},
    {"text": "Cardiology", "icon": Icons.padding_outlined},
    {"text": "Cardiology", "icon": Icons.zoom_in_map},
    {"text": "Cardiology", "icon": Icons.cabin},
  ];
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);

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
                  child: IconButton(
                    icon: Icon(
                      mylist[index]["icon"] as IconData,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      dataBloc.add(onDoctorsearchByspeciality(
                          speciality:
                              (mylist[index]["text"] as String).toLowerCase()));
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
  }
}
