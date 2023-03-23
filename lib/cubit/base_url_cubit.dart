import 'package:bloc/bloc.dart';

class BaseUrlCubit extends Cubit<String> {
  BaseUrlCubit() : super("http://192.168.100.3:8000");

  void setBaseUrl(String newUrl) {
    emit(newUrl);
  }
}
