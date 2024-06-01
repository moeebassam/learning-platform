part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState({
    this.courseItem = const <CourseItem>[],
  });

  final List<CourseItem> courseItem;

  CourseState copyWith({
    List<CourseItem>? courseItem,
    int? page,
  }) {
    return CourseState(
      courseItem: courseItem ?? this.courseItem,
    );
  }

  @override
  List<Object> get props => [courseItem];
}
