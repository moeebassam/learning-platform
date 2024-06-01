import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(const CourseDetailState()) {
    on<CourseItemChanged>(_onCourseItemChanged);
    on<LessonItemChanged>(_onLessonItemChanged);
  }

  void _onCourseItemChanged(
      CourseItemChanged event,
      Emitter<CourseDetailState> emit,
      ) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
  void _onLessonItemChanged(
      LessonItemChanged event,
      Emitter<CourseDetailState> emit,
      ) {
    emit(state.copyWith(lessonItem: event.lessonItem));
  }

}
