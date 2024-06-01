part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class CourseItemChanged extends CourseEvent {
  const CourseItemChanged(this.courseItem);

  final List<CourseItem> courseItem;

  @override
  List<Object> get props => [courseItem];
}

