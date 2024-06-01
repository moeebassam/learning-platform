import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ulearning/common/apis/chat.dart';
import 'package:ulearning/common/entities/entities.dart';
import 'package:ulearning/common/utils/security.dart';
import 'package:ulearning/common/values/constant.dart';
import 'package:ulearning/common/widgets/toast.dart';
import 'package:ulearning/global.dart';
import 'package:ulearning/pages/message/voicecall/bloc/voicecall_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceLogic {
  final BuildContext context;
  final db = FirebaseFirestore.instance;
  UserItem userProfile = Global.storageService.getUserProfile();
  final player = AudioPlayer();
  String appId = APPID;
  late final RtcEngine engine;
  late final Timer calltimer;
  int call_m = 0;
  int call_s = 0;
  int call_h = 0;
  bool is_calltimer = false;
  ChannelProfileType channelProfileType =
      ChannelProfileType.channelProfileCommunication;
  String channel_name = "";
  String _callRole = "";
  String _toToken = "";
  String _toName = "";
  String _toAvatar = "";
  String _docId = "";
  String _callTimeNum = "not connected";


  VoiceLogic({
    required this.context,
  });

  void init() async{
    print("---init----- ");
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    context.read<VoiceCallBloc>().add(UserInfoChanged(data["to_avatar"] ?? "", data["to_name"] ?? ""));
    print("call_role----->${data["call_role"]}");
    _callRole = data["call_role"];
    _toToken = data["to_token"] ?? "";
    _docId = data["doc_id"] ?? "";
    _callRole = data["call_role"];
    _toName = data["to_name"];
    _toAvatar = data["to_avatar"];
    bool microphoneStatus = await request_permission(Permission.microphone);
    if(microphoneStatus){
      _initEngine();
    }else{
      Navigator.of(context).pop();
    }

  }

  Future<void> _initEngine() async {

    await player.setAsset("assets/voice/Sound_Horizon.mp3");
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        context.read<VoiceCallBloc>().add(IsJoinedChanged(true));
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
        print("onUserJoined----->${remoteUid}");
        await player.pause();
        if (_callRole == "anchor") {
          _callTime();
          is_calltimer = true;
        }
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) {
     
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        print("onUserOffline----->${remoteUid}");
        leaveChannel(false);
      },
    ));

    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );

   
    await joinChannel();
    print("callRole----->${_callRole}");
    if (_callRole == "anchor") {
      await _sendNotifications("voice");
      await player.play();
    }
  }

  _callTime() async {
    calltimer = Timer.periodic(Duration(seconds: 1), (timer) {
      call_s = call_s + 1;
      if (call_s >= 60) {
        call_s = 0;
        call_m = call_m + 1;
      }
      if (call_m >= 60) {
        call_m = 0;
        call_h = call_h + 1;
      }
      var h = call_h < 10 ? "0${call_h}" : "${call_h}";
      var m = call_m < 10 ? "0${call_m}" : "${call_m}";
      var s = call_s < 10 ? "0${call_s}" : "${call_s}";

      if (call_h == 0) {
        context.read<VoiceCallBloc>().add(CallTimeChanged("${m}:${s}"));
        _callTimeNum = "${call_m} m and ${call_s} s";
      } else {
        context.read<VoiceCallBloc>().add(CallTimeChanged("${h}:${m}:${s}"));
        _callTimeNum = "${call_h} h ${call_m} m and ${call_s} s";
      }
    });
  }

  Future<String> _getToken() async {
    String call_token = "";
    String to_token = "";
    if (_callRole == "anchor") {
      call_token = md5
          .convert(utf8.encode("${userProfile.token}_${_toToken}"))
          .toString();
      to_token = _toToken;
    } else {
      call_token = md5
          .convert(utf8.encode("${_toToken}_${userProfile.token}"))
          .toString();
      to_token = "${userProfile.token}";
    }
    CallTokenRequestEntity callTokenRequestEntity =
        new CallTokenRequestEntity();
    callTokenRequestEntity.call_token = call_token;
    callTokenRequestEntity.to_token = to_token;
    var res = await ChatAPI.call_token(params: callTokenRequestEntity);
    if (res.code == 0) {
      channel_name = res.msg!;
      return res.data!;
    }
    return "";
  }

  _addCallTime() async {

    var msgdata = new ChatCall(
      from_token: userProfile.token,
      to_token: _toToken,
      from_name: userProfile.name,
      to_name: _toName,
      from_avatar: userProfile.avatar,
      to_avatar: _toAvatar,
      call_time: _callTimeNum,
      type: "voice",
      last_time: Timestamp.now(),
    );
    await db
        .collection("chatcall")
        .withConverter(
          fromFirestore: ChatCall.fromFirestore,
          toFirestore: (ChatCall msg, options) => msg.toFirestore(),
        )
        .add(msgdata);
    String sendcontent = "Call time ${_callTimeNum} 【voice】";
    _sendMessage(sendcontent);
  }

  _sendMessage(String sendcontent) async {
    if (_docId.isEmpty) {
      return;
    }
    final content = Msgcontent(
      token: userProfile.token,
      content: sendcontent,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(_docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .add(content);
    var message_res = await db
        .collection("message")
        .doc(_docId)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .get();
    if (message_res.data() != null) {
      var item = message_res.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == userProfile.token) {
        from_msg_num = from_msg_num + 1;
      } else {
        to_msg_num = to_msg_num + 1;
      }
      await db.collection("message").doc(_docId).update({
        "to_msg_num": to_msg_num,
        "from_msg_num": from_msg_num,
        "last_msg": sendcontent,
        "last_time": Timestamp.now()
      });
    }
  }

  joinChannel() async {

    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    String token = await _getToken();
    print("token----->${token}");
    if (token.isEmpty) {
      EasyLoading.dismiss();
      Navigator.of(context).pop();
      return;
    }
    await engine.joinChannel(
        token: token,
        channelId: channel_name,
        uid: 0,
        options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
    if (_callRole == "audience") {
      _callTime();
      is_calltimer = true;
    }
    EasyLoading.dismiss();
  }

  // send notification
  _sendNotifications(String call_type) async {
    CallRequestEntity callRequestEntity = new CallRequestEntity();
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = _toToken;
    callRequestEntity.to_avatar = _toAvatar;
    callRequestEntity.doc_id = _docId;
    callRequestEntity.to_name = _toName;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    print(res);
    if (res.code == 0) {
      print("sendNotifications success");
    } else {}
  }

  leaveChannel(bool is_self) async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    context.read<VoiceCallBloc>().add(IsJoinedChanged(false));
    context.read<VoiceCallBloc>().add(OpenMicrophoneChanged(true));
    context.read<VoiceCallBloc>().add(EnableSpeakerphoneChanged(true));

    if (is_calltimer) {
      calltimer.cancel();
    }
    if (_callRole == "anchor") {
      _addCallTime();
    }
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
    if(is_self){
      await _sendNotifications("cancel");
    }
    EasyLoading.dismiss();
    Navigator.of(context).pop();
  }


   switchMicrophone() async {
     var state_new = context.read<VoiceCallBloc>().state;
    await engine.enableLocalAudio(!state_new.openMicrophone);
    context
        .read<VoiceCallBloc>()
        .add(OpenMicrophoneChanged(!state_new.openMicrophone));
  }

   switchSpeakerphone() async {
    print("switchSpeakerphone--");
    var state_new = context.read<VoiceCallBloc>().state;
    await engine.setEnableSpeakerphone(!state_new.enableSpeakerphone);
    context
        .read<VoiceCallBloc>()
        .add(EnableSpeakerphoneChanged(!state_new.enableSpeakerphone));
  }
}
