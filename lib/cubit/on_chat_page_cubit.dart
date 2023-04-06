import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class OnChatPageCubit extends Cubit<bool> {
  OnChatPageCubit() : super(false);

  void setOnChatPage(bool value) {
    emit(value);
  }
}
