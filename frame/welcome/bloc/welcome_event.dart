part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends WelcomeEvent {
  const PageChanged(this.page);

  final int page;

  @override
  List<Object> get props => [page];
}

