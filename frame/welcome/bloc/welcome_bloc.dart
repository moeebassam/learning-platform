import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/utils/utils.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<PageChanged>(_onPageChanged);

  }

  void _onPageChanged(
      PageChanged event,
      Emitter<WelcomeState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

}
