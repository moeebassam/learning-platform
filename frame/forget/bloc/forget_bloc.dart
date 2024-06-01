import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forget_event.dart';
part 'forget_state.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetBloc() : super(const ForgetState()) {
    on<EmailChanged>(_onEmailChanged);
  }

  void _onEmailChanged(
      EmailChanged event,
      Emitter<ForgetState> emit,
      ) {
    emit(state.copyWith(email: event.email));
  }

}
