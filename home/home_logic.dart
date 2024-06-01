import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/entities/entities.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/global.dart';
import 'package:ulearning/pages/home/bloc/home_bloc.dart';


class HomeLogic{
  final BuildContext context;
  UserItem userProfile = Global.storageService.getUserProfile();

   HomeLogic({
    required this.context,
  });

  void init(){
    asyncPostAllData();
  }

  asyncPostAllData() async {

    var result = await CourseAPI.courseList();
    print(result);
    if(result.code==0){
      context.read<HomeBloc>().add(CourseItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }

  }

}