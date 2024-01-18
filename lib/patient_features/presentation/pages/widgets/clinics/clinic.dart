import 'dart:async';

import 'package:dawini_full/patient_features/presentation/pages/pages/clinicDetails/clinics_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';

// ignore: must_be_immutable
class ClinicWidget extends StatefulWidget {
  List<ClinicEntity> clinics;

  ClinicWidget({
    Key? key,
    required this.clinics,
  }) : super(key: key);

  @override
  State<ClinicWidget> createState() => _ClinicWidgetState();
}

class _ClinicWidgetState extends State<ClinicWidget> {
  PageController mycon = PageController(viewportFraction: 0.7.w);

  late Timer timer;

  int selectedindex = 0;
  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    timer = Timer.periodic(const Duration(seconds: 4), (timez) {
      if (mycon.hasClients) {
        mycon.animateToPage(
          (mycon.page!.toInt() + 1) % widget.clinics.length,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150.h,
      width: double.infinity,
      child: PageView.builder(
        onPageChanged: (int index) {
          setState(() {
            selectedindex = index;
          });
        },
        controller: mycon,
        itemCount: widget.clinics.length,
        itemBuilder: (context, index) {
          double scale = selectedindex == index ? 0.9.h : 0.7.h;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClinicsDetails(uid: widget.clinics[index].uid)),
              );
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: scale, end: scale),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(72, 146, 146, 146),

                        width: 2.w, // Set the border width
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 1.w),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromARGB(31, 204, 204, 204)
                                  .withOpacity(0.3),
                              border: Border.all(
                                color: const Color.fromARGB(
                                    0, 158, 158, 158), // Set the border color
                                width: 2.w, // Set the border width
                              ),
                            ),
                            height: 110.h,
                            width: 100.h,
                            child: Image.asset(
                              "assets/images/clinic.png",
                              fit: BoxFit.scaleDown,
                              scale: 1.w,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, top: 15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.clinics[index].ClinicName,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 50.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    widget.clinics[index].phoneNumber,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    widget.clinics[index].city +
                                        " , " +
                                        widget.clinics[index].wilaya,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: widget.clinics[index].atSerivce
                                          ? Color(0xFF2CDBC6)
                                          : Color.fromARGB(255, 219, 44, 44),
                                      size: 16.w,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      widget.clinics[index].atSerivce
                                          ? " At Service"
                                          : "Not at Service",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
