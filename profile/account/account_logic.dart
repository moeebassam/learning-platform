import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/pages/profile/account/bloc/account_bloc.dart';


class AccountLogic{
  final BuildContext context;

  AccountLogic({
    required this.context,
  });

  void init(){
    asyncPostAllData();
  }

  asyncPostAllData() async {

    var result = await CourseAPI.orderList();
    print(result);
    if(result.code==0){
      context.read<AccountBloc>().add(AccountItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }

  }

}