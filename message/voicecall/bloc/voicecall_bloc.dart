import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'voicecall_event.dart';
part 'voicecall_state.dart';

class VoiceCallBloc extends Bloc<VoiceCallEvent, VoiceCallState> {
  VoiceCallBloc() : super(const VoiceCallState()) {
    on<UserInfoChanged>(_onUserInfoChanged);
    on<CallTimeChanged>(_onCallTimeChanged);
    on<OpenMicrophoneChanged>(_onOpenMicrophoneChanged);
    on<IsJoinedChanged>(_onIsJoinedChanged);
    on<EnableSpeakerphoneChanged>(_onEnableSpeakerphoneChanged);

  }

  void _onUserInfoChanged(
      UserInfoChanged event,
      Emitter<VoiceCallState> emit,
      ) {
    emit(state.copyWith(toAvatar: event.toAvatar,toName:event.toName));
  }

  void _onCallTimeChanged(
      CallTimeChanged event,
      Emitter<VoiceCallState> emit,
      ) {
    emit(state.copyWith(callTime: event.callTime));
  }

  void _onOpenMicrophoneChanged(
      OpenMicrophoneChanged event,
      Emitter<VoiceCallState> emit,
      ) {
    emit(state.copyWith(openMicrophone: event.openMicrophone));
  }

  void _onIsJoinedChanged(
      IsJoinedChanged event,
      Emitter<VoiceCallState> emit,
      ) {
    emit(state.copyWith(isJoined: event.isJoined));
  }

  void _onEnableSpeakerphoneChanged(
      EnableSpeakerphoneChanged event,
      Emitter<VoiceCallState> emit,
      ) {
    emit(state.copyWith(enableSpeakerphone: event.enableSpeakerphone));
  }

}
