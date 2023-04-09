import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/helper_rate/get_all_helper_rate_response_model.dart';
import 'package:bantuin/models/helper_rate_model.dart';
import 'package:bantuin/services/helper_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

class HelperViewModel {
  late BuildContext context;
  late HelperService helperService;
  late UserViewModel userVm;
  late String token;

  HelperViewModel(BuildContext context) {
    this.helperService = HelperService(context);
    this.userVm = UserViewModel(context);
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future<bool> requestToBeHelper() async {
    var response = await helperService.requestToBeHelper(token: token);
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Request To Be Helper Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', "Request To Be Helper Success", context);
    await userVm.fetch();
    return true;
  }

  Future<List<HelperRateModel>> getAllRecords({
    required int helperId
  }) async {
    var response = await helperService.getAllRecords(
      token: token,
      helperId: helperId
    );
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return [];
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return [];
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Get Helper`S Records Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return [];
    }

    var rateResponse = GetAllHelperRateResponseModel.fromJson(response);
    return rateResponse.rates;
  }

  Future<bool> giveRateToHelper({
    required int userId, bantuanId, helperId, rating,
    required String message
  }) async {
    var response = await helperService.giveRateToHelper(
      token: token,
      userId: userId,
      bantuanId: bantuanId,
      helperId: helperId,
      rating: rating,
      message: message
    );
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return false;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return false;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Give Rate to Helper Failed', context);
      if (response.data != null) {
        if (response.data.containsKey('message')) {
          showGLobalAlert('danger', response.data['message'], context);
        }
      }
      return false;
    }

    showGLobalAlert('success', "Give Rate to Helper Success", context);
    return true;
  }
}