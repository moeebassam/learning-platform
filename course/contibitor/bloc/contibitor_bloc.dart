import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'contibitor_event.dart';
part 'contibitor_state.dart';

class ContibitorBloc extends Bloc<ContibitorEvent, ContibitorState> {
  ContibitorBloc() : super(const ContibitorState()) {
    on<ContibitorChanged>(_onContibitorChanged);
    on<CourseItemChanged>(_onCourseItemChanged);
  }

  void _onContibitorChanged(
      ContibitorChanged event,
      Emitter<ContibitorState> emit,
      ) {
    emit(state.copyWith(authorItem: event.authorItem));
  }
  void _onCourseItemChanged(
      CourseItemChanged event,
      Emitter<ContibitorState> emit,
      ) {
    emit(state.copyWith(courseItem: event.courseItem));
  }

}
