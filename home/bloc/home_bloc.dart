import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<PageChanged>(_onPageChanged);
    on<CourseItemChanged>(_onCourseItemChanged);
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onCourseItemChanged(
      CourseItemChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(state.copyWith(courseItem: event.courseItem));
  }

}
