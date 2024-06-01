import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/course.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountItemChanged>(_onAccountItemChanged);

  }

  void _onAccountItemChanged(
      AccountItemChanged event,
      Emitter<AccountState> emit,
      ) {
    emit(state.copyWith(courseItem: event.courseItem));
  }

}
