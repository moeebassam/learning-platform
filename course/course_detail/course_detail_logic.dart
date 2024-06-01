import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/entities/entities.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/pages/course/course_detail/bloc/course_detail_bloc.dart';


class CourseDetailLogic{
  final BuildContext context;

  CourseDetailLogic({
    required this.context,
  });

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args["id"]);
    await asyncPostAllData(args["id"]);
    await asyncPostLessonData(args["id"]);
  }

  asyncPostAllData(int? id) async {
    CourseRequestEntity courseRequestEntity = new CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);
    print(result);
    if(result.code==0){
      context.read<CourseDetailBloc>().add(CourseItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }
  }

  asyncPostLessonData(int? id) async {
    print(id);
    LessonRequestEntity lessonRequestEntity = new LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonList(params: lessonRequestEntity);
    print("LessonList---");
    print(result.data!.length);
    if(result.code==0){
      context.read<CourseDetailBloc>().add(LessonItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }
  }

  goPay(int? id) async {
    EasyLoading.show(indicator: CircularProgressIndicator(),maskType: EasyLoadingMaskType.clear,dismissOnTap: true);
    CourseRequestEntity courseRequestEntity = new CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.coursePay(
      params: courseRequestEntity,
    );
    print(result);
    EasyLoading.dismiss();
    if(result.code==0){
      var url = Uri.decodeFull(result.data!);
      print("my url is ---${url}");
      var res = await Navigator.of(context).pushNamed(AppRoutes.PayWebview,arguments: {"url":url});
      if(res=="success"){
        toastInfo(msg: "Pay successful!");
       // Navigator.of(context).pop();
      }else{
        toastInfo(msg: "Picked the wrong pay?");
      }
    }else{
      toastInfo(msg: result.msg!);
    }
  }

}