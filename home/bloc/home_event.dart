part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends HomeEvent {
  const PageChanged(this.page);

  final int page;

  @override
  List<Object> get props => [page];
}
class CourseItemChanged extends HomeEvent {
  const CourseItemChanged(this.courseItem);

  final List<CourseItem> courseItem;

  @override
  List<Object> get props => [courseItem];
}

