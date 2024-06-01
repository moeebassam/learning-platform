import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/frame/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning/pages/frame/sign_in/sign_in_logic.dart';

AppBar buildAppBar() {
  return AppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primarySecondaryBackground,
            height: 1.0,
          )),
      title: Text(
        "Log In",
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ));
}

Widget buildLoginBtn(BuildContext context) {
  return GestureDetector(
      child: Container(
          width: 325.w,
          height: 50.h,
          margin: EdgeInsets.only(top: 100.h, left: 0.w, right: 0.w),
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
            "Log In",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryBackground,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
          ))),
      onTap: () {
        SignInLogic(context: context).handleSignIn("email");
      });
}

Widget buildRegBtn(BuildContext context) {
  return GestureDetector(
      child: Container(
          width: 325.w,
          height: 50.h,
          margin: EdgeInsets.only(top: 20.h, left: 0.w, right: 0.w),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: Center(
              child: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
          ))),
      onTap: () {
      
        Navigator.of(context).pushNamed(AppRoutes.Register);
      });
}

Widget buildEmailInput(BuildContext context) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h, top: 0.h),
    padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourElementText)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 17.w),
          padding: EdgeInsets.only(left: 0.w, top: 0.w),
          width: 16.w,
          height: 16.w,
          child: Image.asset("assets/icons/user.png"),
        ),
        Container(
          width: 280.w,
          height: 50.h,
          child: TextField(
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: "Enter your email address",
              contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: TextStyle(
                color: AppColors.primarySecondaryElementText,
              ),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
            ),
            onChanged: (value) {
              context.read<SignInBloc>().add(EmailChanged(value));
            },
            maxLines: 1,
            autocorrect: false, 
            obscureText: false, 
          ),
        )
      ],
    ),
  );
}

Widget buildPasswordInput(BuildContext context) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h, top: 0.h),
    padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourElementText)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 17.w),
          padding: EdgeInsets.only(left: 0.w, top: 0.w),
          width: 16.w,
          height: 16.w,
          child: Image.asset("assets/icons/lock.png"),
        ),
        Container(
          width: 280.w,
          height: 50.h,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Enter your Password",
              contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: TextStyle(
                color: AppColors.primarySecondaryElementText,
              ),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
            ),
            onChanged: (value) {
              context.read<SignInBloc>().add(PasswordChanged(value));
            },
            maxLines: 1,
            autocorrect: false, 
            obscureText: true, 
          ),
        )
      ],
    ),
  );
}

Widget ForgotPassword(BuildContext context) {
  return Container(
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
        child: Text(
          "Forgot password?",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.primaryText,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.Forget);
        }),
  );
}

Widget buildThirdLogin(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
      padding: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Container(
                width: 40.w,
                height: 40.w,
                child: Image.asset(
                  "assets/icons/google.png",
                  fit: BoxFit.fill,
                )),
            onTap: () {
              SignInLogic(context: context).handleSignIn("google");
            },
          ),
          GestureDetector(
            child: Container(
                width: 40.w,
                height: 40.w,
                child: Image.asset("assets/icons/apple.png", fit: BoxFit.fill)),
            onTap: () {
              SignInLogic(context: context).handleSignIn("apple");
            },
          ),
          GestureDetector(
            child: Container(
                width: 40.w,
                height: 40.w,
                child: Image.asset("assets/icons/facebook.png", fit: BoxFit.fill)),
            onTap: () {
              SignInLogic(context: context).handleSignIn("facebook");
            },
          ),
        ],
      ));
}
