import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'videocall_event.dart';
part 'videocall_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallBloc() : super(const VideoCallState()) {
    on<UserInfoChanged>(_onUserInfoChanged);
    on<CallTimeChanged>(_onCallTimeChanged);
    on<IsJoinedChanged>(_onIsJoinedChanged);
    on<IsReadyPreviewChanged>(_onIsReadyPreviewChanged);
    on<IsShowAvatarChanged>(_onIsShowAvatarChanged);
    on<SwitchCamerasChanged>(_onSwitchCamerasChanged);
    on<SwitchviewChanged>(_onSwitchviewChanged);
    on<SwitchRenderChanged>(_onSwitchRenderChanged);
    on<RemoteUidChanged>(_onRemoteUidChanged);
    on<ChannelIdChanged>(_onChannelIdChanged);

  }

  void _onUserInfoChanged(
      UserInfoChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(toAvatar: event.toAvatar,toName:event.toName));
  }

  void _onCallTimeChanged(
      CallTimeChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(callTime: event.callTime));
  }

  void _onIsJoinedChanged(
      IsJoinedChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(isJoined: event.isJoined));
  }


  void _onIsReadyPreviewChanged(
      IsReadyPreviewChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(isReadyPreview: event.isReadyPreview));
  }

  void _onIsShowAvatarChanged(
      IsShowAvatarChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(isShowAvatar: event.isShowAvatar));
  }

  void _onSwitchCamerasChanged(
      SwitchCamerasChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(switchCameras: event.switchCameras));
  }

  void _onSwitchviewChanged(
      SwitchviewChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(switchview: event.switchview));
  }

  void _onSwitchRenderChanged(
      SwitchRenderChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(switchRender: event.switchRender));
  }
  void _onRemoteUidChanged(
      RemoteUidChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(remoteUid: event.remoteUid));
  }

  void _onChannelIdChanged(
      ChannelIdChanged event,
      Emitter<VideoCallState> emit,
      ) {
    emit(state.copyWith(channelId: event.channelId));
  }

}
