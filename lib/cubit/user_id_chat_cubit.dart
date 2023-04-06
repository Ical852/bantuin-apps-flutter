import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class UserIdChatCubit extends Cubit<int> {
  UserIdChatCubit() : super(0);

  void setUserIdOnChat(int value) {
    emit(value);
  }
}
