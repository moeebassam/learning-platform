import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(const CourseState()) {
    on<CourseItemChanged>(_onCourseItemChanged);
  }

  void _onCourseItemChanged(
      CourseItemChanged event,
      Emitter<CourseState> emit,
      ) {
    emit(state.copyWith(courseItem: event.courseItem));
  }

}
