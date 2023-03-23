import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class PageCubit extends Cubit<String> {
  PageCubit() : super("home");

  void setPage(String page) {
    emit(page);
  }
}
