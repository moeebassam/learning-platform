import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState()) {
    on<MessageChanged>(_onMessageChanged);
    on<LoadStatusChanged>(_onLoadStatusChanged);

  }

  void _onMessageChanged(
      MessageChanged event,
      Emitter<MessageState> emit,
      ) {

    emit(state.copyWith(message: event.message));
  }
  void _onLoadStatusChanged(
      LoadStatusChanged event,
      Emitter<MessageState> emit,
      ) {

    emit(state.copyWith(loadStatus: event.loadStatus));
  }

}
