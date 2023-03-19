import 'package:bloc/bloc.dart';

class TokenCubit extends Cubit<String> {
  TokenCubit() : super("");

  void setToken(String token) {
    emit(token);
  }
}
