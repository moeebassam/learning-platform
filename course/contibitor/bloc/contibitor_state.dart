part of 'contibitor_bloc.dart';

class ContibitorState extends Equatable {
  const ContibitorState({
    this.authorItem,
    this.courseItem = const <CourseItem>[],
  });

  final AuthorItem? authorItem;
  final List<CourseItem> courseItem;

  ContibitorState copyWith({
    AuthorItem? authorItem,
    List<CourseItem>? courseItem,
  }) {
    return ContibitorState(
      authorItem: authorItem ?? this.authorItem,
      courseItem: courseItem ?? this.courseItem,
    );
  }

  @override
  List<Object?> get props => [authorItem,courseItem];
}
