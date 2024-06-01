import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning/common/apis/apis.dart';
import 'package:ulearning/common/entities/entities.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/widgets/widgets.dart';
import 'package:ulearning/pages/course/lesson/bloc/lesson_bloc.dart';
import 'package:video_player/video_player.dart';


class LessonLogic{
  final BuildContext context;
  VideoPlayerController? videoController;

  LessonLogic({
    required this.context,
  });

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args["id"]);
    context.read<LessonBloc>().add(IsPlayChanged(false));
    await asyncPostLessonData(args["id"]);

  }
  

  asyncPostLessonData(int? id) async {
    print(id);
    LessonRequestEntity lessonRequestEntity = new LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonDetail(params: lessonRequestEntity);
    print("LessonList---");
    print(result.data!.length);
    if(result.code==0){
      context.read<LessonBloc>().add(LessonVideoItemChanged(result.data!));
      if(result.data!.length>0){
        var url = result.data!.elementAt(0).url;
        videoController = VideoPlayerController.network(url!);
        var initializeVideoPlayerFuture = videoController?.initialize();
        context.read<LessonBloc>().add(UrlItemChanged(initializeVideoPlayerFuture));
      }

    }else{
      toastInfo(msg: 'internet error');
    }
  }

  playVideo(String url){
    if(videoController!=null){
      videoController?.pause();
      videoController?.dispose();
    }
    videoController = VideoPlayerController.network(url);

    context.read<LessonBloc>().add(IsPlayChanged(false));
    context.read<LessonBloc>().add(UrlItemChanged(null));
    var initializeVideoPlayerFuture =
        videoController?.initialize().then((_) {
          videoController
              ?.seekTo(Duration(milliseconds: 0));
          videoController?.play();
        });
    context.read<LessonBloc>().add(UrlItemChanged(initializeVideoPlayerFuture));
    context.read<LessonBloc>().add(IsPlayChanged(true));
  }



}