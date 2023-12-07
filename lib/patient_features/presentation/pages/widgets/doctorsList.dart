import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/pages/doctorDetails/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(builder: (context, state) {
      if (state is DoctorLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SeeAllDoctors) {
        final doctors = state.doctor;

        return Doctors(
          doctors: doctors,
        );
      } else if (state is DoctorLoaded) {
        final doctors = state.doctor;

        return Doctors(
          doctors: doctors,
        );
      } else if (state is DoctorLoadingFailure) {
        return ErrorWidget(state.message);
      } else {
        // context.read<DoctorBloc>().add(DoctorinitialEvent());
        return Container();
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
          itemCount: widget.doctors.length, // Number of items in the grid
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // dataBloc.add(onDoctorChoose(doctor: widget.doctors[index]));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          doctorDetails(doctor: widget.doctors[index])),
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
                        color: Colors.grey.withOpacity(0.3),
                        height: 130.h,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "Dr. " + widget.doctors[index].lastName,
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
                          widget.doctors[index].speciality,
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
                                widget.doctors[index].city +
                                    ", " +
                                    widget.doctors[index].wilaya,
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
                                color: widget.doctors[index].atSerivce
                                    ? Colors.teal
                                    : const Color.fromARGB(255, 150, 0, 0)),
                            SizedBox(width: 5.h),
                            Text(
                              widget.doctors[index].atSerivce
                                  ? "At service "
                                  : " Not at service ",
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
