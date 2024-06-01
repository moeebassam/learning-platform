import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ulearning/common/entities/entities.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(const LessonState()) {
    on<LessonVideoItemChanged>(_onLessonItemChanged);
    on<UrlItemChanged>(_onUrlItemChanged);
    on<IsPlayChanged>(_onIsPlayChanged);
  }

  void _onLessonItemChanged(
      LessonVideoItemChanged event,
      Emitter<LessonState> emit,
      ) {
    emit(state.copyWith(lessonItem: event.lessonItem));
  }

  void _onUrlItemChanged(
      UrlItemChanged event,
      Emitter<LessonState> emit,
      ) {
    emit(state.copyWith(initializeVideoPlayerFuture: event.initializeVideoPlayerFuture));
  }
  void _onIsPlayChanged(
      IsPlayChanged event,
      Emitter<LessonState> emit,
      ) {
    emit(state.copyWith(isPlay: event.isPlay));
  }

}
