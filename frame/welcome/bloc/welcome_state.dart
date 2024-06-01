part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  const WelcomeState({
    this.page=0,
  });

  final int page;

  WelcomeState copyWith({
    int? page,
  }) {
    return WelcomeState(
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [page];
}
