part of 'introduction_bloc.dart';

sealed class IntroductionState extends Equatable {
  const IntroductionState();

  @override
  List<Object> get props => [];
}

final class WelcomeState extends IntroductionState {}

final class LoadingState extends IntroductionState {}

final class LanguageState extends IntroductionState {
  final String language;

  LanguageState({required this.language});

  @override
  List<Object> get props => [language];
}

final class TypeState extends IntroductionState {
  final String type;

  TypeState({required this.type});

  @override
  List<Object> get props => [type];
}

final class IgnoreIntorductionState extends IntroductionState {
  final String Screen;

  IgnoreIntorductionState({required this.Screen});

  @override
  List<Object> get props => [Screen];
}
