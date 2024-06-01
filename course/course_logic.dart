import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/pages/course/bloc/course_bloc.dart';


class CourseLogic{
  final BuildContext context;

  CourseLogic({
    required this.context,
  });

  void init(){
    asyncPostAllData();
  }

  asyncPostAllData() async {
    var result = await CourseAPI.courseList();
    print(result);
    if(result.code==0){
      context.read<CourseBloc>().add(CourseItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }

  }

}