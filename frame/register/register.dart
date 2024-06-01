import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/frame/register/bloc/register_bloc.dart';
import 'package:ulearning/pages/frame/register/register_logic.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => Register());
  }

  @override
  State<Register> createState() => _RegisterPage();
}

class _RegisterPage extends State<Register> {
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Container(
              color: Colors.white,
              child: SafeArea(
              child: Scaffold(
            appBar: _buildAppBar(),
            backgroundColor: AppColors.primaryBackground,
            body: CustomScrollView(slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 0.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 30.h),
                      child: Text(
                        "Enter your details below & free sign up",
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
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    margin: EdgeInsets.only(bottom: 0.h, top: 66.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
                          child: Text(
                            "User name",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        _buildUserNameInput(),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
                          child: Text(
                            "Email",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        _buildEmailInput(),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        _buildPasswordInput(),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h, top: 0.h),
                          child: Text(
                            "Confirm Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        _buildConfirmPasswordInput(),
                        Container(
                          width: 260.w,
                          child: GestureDetector(
                              child: Text(
                                "By creating an account you have to agree with our them & condition.",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.primaryThreeElementText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                ),
                              ),
                              onTap: () {

                              }),
                        ),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )));
        });
  }

  AppBar _buildAppBar() {
    return AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primarySecondaryBackground,
              height: 1.0,
            )),
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ));
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
        child: Container(
            width: 325.w,
            height: 50.h,
            margin: EdgeInsets.only(top: 60.h, left: 0.w, right: 0.w),
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
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ))),
        onTap: () {
          RegisterLogic(context: context).handleEmailRegister();
        });
  }

  Widget _buildUserNameInput() {
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
              decoration: InputDecoration(
                hintText: "Enter your user name",
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
                context.read<RegisterBloc>().add(UserNameChanged(value));
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

  Widget _buildEmailInput() {
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
              decoration: InputDecoration(
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
                context.read<RegisterBloc>().add(EmailChanged(value));
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

  Widget _buildPasswordInput() {
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
              decoration: InputDecoration(
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
                context.read<RegisterBloc>().add(PasswordChanged(value));
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

  Widget _buildConfirmPasswordInput() {
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
              decoration: InputDecoration(
                hintText: "Enter your Confirm Password",
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
                context.read<RegisterBloc>().add(RePasswordChanged(value));
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


}
