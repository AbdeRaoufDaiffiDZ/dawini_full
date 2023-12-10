import 'package:ff/Widget/UserTypeSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class myappbar extends StatelessWidget implements PreferredSizeWidget {
  const myappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: Image.asset(
                "images/dawini.png",
                width: 110.w,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeft,
                      child: const UserTypeSelector(),
                    ));
              },
              icon: Icon(
                Icons.menu,
                size: 30.w,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
