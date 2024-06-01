import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/utils/utils.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/frame/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning/pages/frame/sign_in/sign_in_logic.dart';
import 'package:ulearning/pages/frame/sign_in/widgets/build_content.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});


  @override
  State<SignIn> createState() => _SignInPage();
}

class _SignInPage extends State<SignIn> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          Logger.write(state.email);
          Logger.write(state.password);
        },
        builder: (context, state) {

          return Container(
              color: Colors.white,
              child: SafeArea(
              child: Scaffold(
            appBar: buildAppBar(),
            backgroundColor: AppColors.primaryBackground,
            body: CustomScrollView(slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 80.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child:buildThirdLogin(context),
                  )),
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 0.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child:Container(
                      child: Text(
                        "Or use your email account login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryThreeElementText,
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.w,
                  horizontal: 0.w,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left:25.w,right: 25.w),
                    margin: EdgeInsets.only(bottom: 0.h,top: 66.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
                          child: Text(
                            "Email",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),),
                        buildEmailInput(context),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h,top: 0.h),
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),),
                        buildPasswordInput(context),
                        ForgotPassword(context),
                        buildLoginBtn(context),
                        buildRegBtn(context)
                      ],),),
                ),
              ),
            ]),
          )));
        });
  }
}
