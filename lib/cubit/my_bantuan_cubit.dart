import 'package:bantuin/models/bantuan_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class MyBantuanCubit extends Cubit<List<BantuanModel>> {
  MyBantuanCubit() : super([]);

  void setMyBantuan(List<BantuanModel> bantuans) {
    emit(bantuans);
  }
}
