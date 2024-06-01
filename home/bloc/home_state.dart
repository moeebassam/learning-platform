part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.courseItem = const <CourseItem>[],
    this.page = 0,
  });

  final List<CourseItem> courseItem;
  final int page;

  HomeState copyWith({
    List<CourseItem>? courseItem,
    int? page,
  }) {
    return HomeState(
      courseItem: courseItem ?? this.courseItem,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [page,courseItem];
}
