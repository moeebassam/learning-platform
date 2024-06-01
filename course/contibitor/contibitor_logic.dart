import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/entities/entities.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/global.dart';
import 'package:ulearning/pages/course/contibitor/bloc/contibitor_bloc.dart';

class ContibitorLogic {
  final BuildContext context;
  final db = FirebaseFirestore.instance;
  UserItem userProfile = Global.storageService.getUserProfile();

  ContibitorLogic({
    required this.context,
  });

  void init() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args["token"]);
    asyncPostAllData(args["token"]);
    asyncPostCourseData(args["token"]);
  }

  goChat(AuthorItem authorItem) async{
     if(authorItem.token==userProfile.token){
       toastInfo(msg: "Can't chat with yourself！");
       return;
     }
    var from_messages = await db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    ).where("from_token", isEqualTo: userProfile.token).where("to_token", isEqualTo: authorItem.token).get();
    var to_messages = await db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    ).where("from_token", isEqualTo: authorItem.token).where("to_token", isEqualTo: userProfile.token).get();

    if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
      print("----from_messages--to_messages--empty--");
      var msgdata = new Msg(
        from_token:userProfile.token,
        to_token:authorItem.token,
        from_name:userProfile.name,
        to_name:authorItem.name,
        from_avatar:userProfile.avatar,
        to_avatar:authorItem.avatar,
        from_online:userProfile.online,
        to_online:authorItem.online,
        last_msg:"",
        last_time:Timestamp.now(),
        msg_num:0,
      );
      var doc_id = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      ).add(msgdata);
      Navigator.of(context).pushNamed(AppRoutes.Chat, arguments: {"doc_id": doc_id.id,"to_token":authorItem.token??"","to_name":authorItem.name??"","to_avatar":authorItem.avatar??"","to_online":authorItem.online.toString()});
    }else{
      if(!from_messages.docs.isEmpty){
        print("---from_messages");
        print(from_messages.docs.first.id);
        Navigator.of(context).pushNamed(AppRoutes.Chat, arguments: {"doc_id": from_messages.docs.first.id,"to_token":authorItem.token??"","to_name":authorItem.name??"","to_avatar":authorItem.avatar??"","to_online":authorItem.online.toString()});
      }
      if(!to_messages.docs.isEmpty){
        print("---to_messages");
        print(to_messages.docs.first.id);
        Navigator.of(context).pushNamed(AppRoutes.Chat, arguments: {"doc_id": to_messages.docs.first.id,"to_token":authorItem.token??"","to_name":authorItem.name??"","to_avatar":authorItem.avatar??"","to_online":authorItem.online.toString()});
      }

    }

  }

  asyncPostAllData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.courseAuthor(params: authorRequestEntity);
    print(result);
    if (result.code == 0) {
      context.read<ContibitorBloc>().add(ContibitorChanged(result.data!));
    } else {
      toastInfo(msg: 'internet error');
    }
  }
  asyncPostCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await CourseAPI.authorCourseList(params: authorRequestEntity);
    print(result);
    if(result.code==0){
      context.read<ContibitorBloc>().add(CourseItemChanged(result.data!));
    }else{
      toastInfo(msg: 'internet error');
    }

  }
}
