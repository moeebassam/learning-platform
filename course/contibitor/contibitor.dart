import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/course/contibitor/bloc/contibitor_bloc.dart';
import 'package:ulearning/pages/course/contibitor/contibitor_logic.dart';

class Contibitor extends StatefulWidget {
  const Contibitor({super.key});

  @override
  State<Contibitor> createState() => _ContibitorPage();
}

class _ContibitorPage extends State<Contibitor> {
  late ContibitorLogic contibitorLogic;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    contibitorLogic = ContibitorLogic(context: context);
    contibitorLogic.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContibitorBloc, ContibitorState>(
        builder: (context, state) {
      return Container(
          color: Colors.white,
          child: SafeArea(
          child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 25.w,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: 325.w,
                height: 220.h,
                child: Stack(
                  children: [
                    Container(
                      width: 325.w,
                      height: 160.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/background.png'),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.h)),
                      ),
                    ),
                    Positioned(
                        bottom: 0, left: 0, child: _menuView(context, state))
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Container(
              margin: EdgeInsets.only(top: 0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "About Me",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 11.h),
                    child: Text(
                      "${state.authorItem != null ? state.authorItem!.description : ""}",
                      textAlign: TextAlign.start,
                      strutStyle: StrutStyle(height: 1),
                      style: TextStyle(
                        color: AppColors.primaryThreeElementText,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: 330.w,
                      height: 50.h,
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 13.h, bottom: 5.h),
                      decoration: BoxDecoration(
                          color: AppColors.primaryElement,
                          borderRadius: BorderRadius.all(Radius.circular(10.w)),
                          border: Border.all(color: AppColors.primaryElement)),
                      child: Text(
                        "Go Chat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryElementText,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (state.authorItem != null) {
                        contibitorLogic.goChat(state.authorItem!);
                      }
                    },
                  ),
                ],
              ),
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 28.h,
              left: 25.w,
              right: 25.w,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: Text(
                  "Author Courese List",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 18.h,
              horizontal: 25.w,
            ),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
              (content, index) {
                return _buildListItem(content, index, state);
              },
              childCount: state.courseItem.length,
            )),
          ),
        ]),
      )));
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        child: Text(
          "Contibitor",
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _menuView(BuildContext context, ContibitorState state) {
    return Container(
        width: 325.w,
        margin: EdgeInsets.only(
          top: 0.h,
          bottom: 0.h,
          left: 20.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.authorItem == null?Container():Container(
              width: 80.h,
              height: 80.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "${state.authorItem!.avatar}"),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50.h),
                  Container(
                    margin: EdgeInsets.only(left: 6.w),
                    child: Text(
                      "${state.authorItem != null ? state.authorItem!.name : ""}",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6.w, bottom: 10.h, top: 5.h),
                    child: Text(
                      "${state.authorItem != null ? state.authorItem!.job : ""}",
                      style: TextStyle(
                        color: AppColors.primarySecondaryElementText,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/icons/people.png"),
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${state.authorItem != null ? state.authorItem!.follow : ""}",
                                style: TextStyle(
                                  color: AppColors.primaryThreeElementText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/icons/star.png"),
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${state.authorItem != null ? state.authorItem!.score : "0"}",
                                style: TextStyle(
                                  color: AppColors.primaryThreeElementText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/icons/download.png"),
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${state.authorItem != null ? state.authorItem!.download : "0"}",
                                style: TextStyle(
                                  color: AppColors.primaryThreeElementText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildListItem(
      BuildContext context, int index, ContibitorState state) {
    return Container(
      width: 325.w,
      height: 80.h,
      margin: EdgeInsets.only(
        bottom: 15.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.CourseDetail,arguments:{"id":state.courseItem.elementAt(index).id});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 60.h,
                        width: 60.h,
                        margin: EdgeInsets.only(left: 5.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${state.courseItem.elementAt(index).thumbnail}"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(15.h)),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 230.w,
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "${state.courseItem.elementAt(index).name}",
                             overflow: TextOverflow.clip,
                             maxLines: 1,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 230.w,
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "${state.courseItem.elementAt(index).lesson_num} lesson",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 6.w),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         alignment: Alignment.center,
                        //         child: Image(
                        //           image: AssetImage("assets/icons/star(1).png"),
                        //           width: 10.w,
                        //           height: 10.h,
                        //         ),
                        //       ),
                        //       Container(
                        //         child: Text(
                        //           "${state.courseItem.elementAt(index).score}",
                        //           style: TextStyle(
                        //             color: AppColors.primaryThreeElementText,
                        //             fontWeight: FontWeight.normal,
                        //             fontSize: 9.sp,
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    )
                  ]),
            ],
          )),
    );
  }
}
