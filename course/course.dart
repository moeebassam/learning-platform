import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/routes/routes.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/course/bloc/course_bloc.dart';
import 'package:ulearning/pages/course/course_logic.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CoursePage();
}

class _CoursePage extends State<Course> {
  late CourseLogic courseLogic;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    courseLogic = CourseLogic(context: context);
    courseLogic.init();
    super.didChangeDependencies();


  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
      return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: state.courseItem.isEmpty
            ? Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  color: Colors.black26, strokeWidth: 2)),
        )
            : CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 25.w,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: 325.w,
                height: 190.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/Art.png'),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25.w,
            ),
            sliver: SliverToBoxAdapter(child: _searchView(context, state)),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25.w,
            ),
            sliver: SliverToBoxAdapter(child: _menuView(context, state)),
          ),
         SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 25.w,
            ),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
              (content, index) {
                return _buildListItem(content,index,state);
              },
              childCount: state.courseItem.length,
            )),
          ),
          // SliverPadding(
          //     padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 0.w),
          //     sliver: SliverToBoxAdapter(
          //       child: Align(
          //         alignment: Alignment.center,
          //         child: new Text('loading...'),
          //       ),
          //     )),
        ]),
      );
      ;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 18.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          Container(
            child: Text(
              "Your Courses",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          Container(
            width: 24.w,
            height: 24.h,
            child: Image.asset("assets/icons/shopping-cart.png"),
          ),
        ],
      ),
    ));
  }

  Widget _searchView(BuildContext context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 280.w,
          height: 40.h,
          margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
          padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
          decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
              border: Border.all(color: AppColors.primaryFourElementText)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.only(left: 0.w, top: 0.w),
                width: 16.w,
                height: 16.w,
                child: Image.asset("assets/icons/search.png"),
              ),
              Container(
                width: 240.w,
                height: 40.h,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Search your course...",
                    hintStyle: TextStyle(
                      color: AppColors.primaryThreeElementText,
                    ),
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
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                  onChanged: (value) {
                    // controller.state.email.value = value;
                  },
                  maxLines: 1,
                  autocorrect: false, 
                  obscureText: false, 
                ),
              )
            ],
          ),
        ),
        Container(
          width: 40.h,
          height: 40.h,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(Radius.circular(13.w)),
              border: Border.all(color: AppColors.primaryElement)),
          child: Image.asset("assets/icons/options.png"),
        ),
      ],
    );
  }

  Widget _menuView(BuildContext context, state) {
    return Container(
        width: 325.w,
        margin: EdgeInsets.only(
          top: 15.h,
          bottom: 5.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
              child: Text(
                "All course",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
              child: Text(
                "See All",
                style: TextStyle(
                  color: AppColors.primaryThreeElementText,
                  fontWeight: FontWeight.normal,
                  fontSize: 10.sp,
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildListItem(BuildContext context,int index,CourseState state) {
    return Container(
      width: 325.w,
      height: 80.h,
      margin: EdgeInsets.only(
        bottom: 15.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 1), 
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
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${state.courseItem.elementAt(index).thumbnail}"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(
                    Radius.circular(15.h)),
              )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180.w,
                          margin: EdgeInsets.only(left: 6.w),
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
                          width: 180.w,
                          margin: EdgeInsets.only(left: 6.w),
                          child: Text(
                            "${state.courseItem.elementAt(index).lesson_num} Lesson",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.primaryThreeElementText,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
              
              Container(
                width: 55.w,
                alignment: Alignment.centerRight,
                child: Text(
                  "\$${state.courseItem.elementAt(index).price}",
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
