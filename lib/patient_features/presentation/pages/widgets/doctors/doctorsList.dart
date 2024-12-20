import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/Condtions/doctor_state_conditions.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/pages/doctorDetails/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctors_data_usecase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorEntity>>(
        stream: GetDoctorsStreamInfoUseCase.excute(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          {
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
            return BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
              return DoctorStateConditions(state, data);
            });
          }
        });
  }
}

class Doctors extends StatefulWidget {
  final List<DoctorEntity> doctors;

  const Doctors({super.key, required this.doctors});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;

    List<DoctorEntity> data = widget.doctors;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin:
            const EdgeInsets.only(top: 1), // Adjust the top margin as needed
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 1.w, // Spacing between columns
              mainAxisSpacing: 1.h, // Spacing between rows
              mainAxisExtent: 320),
          itemCount: data.length, // Number of items in the grid
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          doctorDetails(uid: widget.doctors[index].uid)),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(
                      left: 6.w, right: 6.w, top: 14.h, bottom: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1.w, // Set the border width
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        color:
                            Color.fromARGB(31, 204, 204, 204).withOpacity(0.3),
                        height: 130.h,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/maleDoctor.png",
                          fit: BoxFit.scaleDown,
                          scale: 1.5.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          data.isNotEmpty ? "Dr. " + data[index].lastName : "",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          data.isNotEmpty ? data[index].speciality : "",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18.sp,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 5.w),
                            Container(
                              width: 120.w,
                              child: Text(
                                data.isNotEmpty
                                    ? data[index].city +
                                        ", " +
                                        data[index].wilaya
                                    : "",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.w),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Icon(Icons.circle,
                                size: 16.w,
                                color: data.isNotEmpty
                                    ? data[index].atSerivce
                                        ? Colors.teal
                                        : const Color.fromARGB(255, 150, 0, 0)
                                    : Color.fromARGB(0, 150, 0, 0)),
                            SizedBox(width: 5.h),
                            Text(
                              data.isNotEmpty
                                  ? data[index].atSerivce
                                      ? text.at_service
                                      : text.not_at_service
                                  : "",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
