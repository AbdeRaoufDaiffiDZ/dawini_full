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
  final cc = [
    Image.asset(
      "assets/images/pp.png",
      fit: BoxFit.cover,
    ),
    Image.asset("assets/images/xx.png"),
    Image.asset("assets/images/cc.png")
  ];
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
          double scale = selectedindex == index ? 1.1 : 0.8;

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
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Container(
                            width: 120.w,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              "assets/images/pp.png",
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
