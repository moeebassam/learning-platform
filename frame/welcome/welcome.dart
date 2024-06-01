import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/common/values/constant.dart';
import 'package:ulearning/global.dart';
import 'package:ulearning/pages/frame/welcome/bloc/welcome_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Welcome());
  }

  @override
  State<Welcome> createState() => _WelcomePage();
}

class _WelcomePage extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
      return Container(
          color: Colors.white,
          child: SafeArea(
          child: Scaffold(
              body: Container(
        width: 375.w,
        margin: EdgeInsets.only(top: 34.h),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) {
                BlocProvider.of<WelcomeBloc>(context).add(PageChanged(index));
              },
              controller: pageController,
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 345.w,
                      height: 345.w,
                      child: Image.asset("assets/images/reading.png",
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: Text("First See Learning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    Container(
                      width: 375.w,
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        "Forget about a for of paper all knowledge in one learning!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildTLogin(context, 1, "Next")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 345.w,
                      height: 345.w,
                      child: Image.asset("assets/images/man.png",
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: Text("Connect With Everyone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    Container(
                      width: 375.w,
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        "Always keep in touch with your tutor & friend. let’s get connected!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildTLogin(context, 2, "Next")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 345.w,
                      height: 345.w,
                      child: Image.asset("assets/images/boy.png",
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: Text("Always Fascinated Learning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    Container(
                      width: 375.w,
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        "Anywhere, anytime. The time is at your discretion so study whenever you want.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildTLogin(context, 3, "Get Started")
                  ],
                ),
                const SizedBox(height: 10,),
                
              ],
            ),
            Positioned(
                bottom: 100,
                child: DotsIndicator(
                  onTap: (index){
                    
                    pageController.animateToPage(
                      index.toInt(),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                mainAxisAlignment: MainAxisAlignment.center,
                reversed: false,
                dotsCount: 3,
                position: state.page.toDouble(),
                decorator: DotsDecorator(
                  color: AppColors.primaryThreeElementText,
                  activeColor: AppColors.primaryElement,
                  size: const Size.square(8.0),
                  activeSize: const Size(18.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                )
            ))
          ],
        ),
      ))));
    });
  }

  Widget buildTLogin(BuildContext context, int index, String title) {
    return GestureDetector(
        child: Container(
            width: 325.w,
            height: 50.h,
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), 
                ),
              ],
            ),
            child: Center(
                child: Text(
              "${title}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBackground,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ))),
        onTap: () {
          if (index < 3) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            Global.storageService.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, true);
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.Sign_in, (Route<dynamic> route) => false);
          }
        });
  }
}
