import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pay_webview_event.dart';
part 'pay_webview_state.dart';

class PayWebviewBloc extends Bloc<PayWebviewEvent, PayWebviewState> {
  PayWebviewBloc() : super(const PayWebviewState()) {
    on<UrlChanged>(_onUrlChanged);
  }

  void _onUrlChanged(
      UrlChanged event,
      Emitter<PayWebviewState> emit,
      ) {
    emit(state.copyWith(url: event.url));
  }

}
