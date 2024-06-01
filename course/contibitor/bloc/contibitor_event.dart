part of 'contibitor_bloc.dart';

abstract class ContibitorEvent extends Equatable {
  const ContibitorEvent();

  @override
  List<Object> get props => [];
}

class ContibitorChanged extends ContibitorEvent {
  const ContibitorChanged(this.authorItem);

  final AuthorItem authorItem;

  @override
  List<Object> get props => [authorItem];
}

class CourseItemChanged extends ContibitorEvent {
  const CourseItemChanged(this.courseItem);

  final List<CourseItem> courseItem;

  @override
  List<Object> get props => [courseItem];
}

