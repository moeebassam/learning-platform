part of 'course_detail_bloc.dart';

class CourseDetailState extends Equatable {
  const CourseDetailState({
    this.courseItem,
    this.lessonItem=const <LessonItem>[],
  });

  final CourseItem? courseItem;
  final List<LessonItem> lessonItem;

  CourseDetailState copyWith({
    CourseItem? courseItem,
    List<LessonItem>? lessonItem,
  }) {
    return CourseDetailState(
      courseItem: courseItem ?? this.courseItem,
      lessonItem: lessonItem ?? this.lessonItem,
    );
  }

  @override
  List<Object?> get props => [courseItem,lessonItem];
}
