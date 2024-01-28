part of 'libraryscreen_cubit.dart';

@immutable
sealed class LibraryscreenState {}

final class LibraryscreenInitial extends LibraryscreenState {}

final class Loading extends LibraryscreenState {}

final class Success extends LibraryscreenState {}

final class Error extends LibraryscreenState {
  final Function onCall;
  final String error;
  Error({required this.onCall , required this.error});
}
