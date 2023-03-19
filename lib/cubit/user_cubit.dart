import 'package:bantuin/models/user_model.dart';
import 'package:bloc/bloc.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel());

  void setUserData(UserModel user) {
    emit(user);
  }
}
