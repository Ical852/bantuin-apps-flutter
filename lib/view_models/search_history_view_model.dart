import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/search_histories/get_search_histories_response_model.dart';
import 'package:bantuin/models/search_history_model.dart';
import 'package:bantuin/services/search_history_service.dart';
import 'package:bantuin/view_models/user_view_model.dart';
import 'package:flutter/material.dart';

class SearchHistoryViewModel {
  late BuildContext context;
  late SearchHistoryService searchHistoryService;
  late UserViewModel userVm;
  late String token;

  SearchHistoryViewModel(BuildContext context) {
    this.searchHistoryService = SearchHistoryService(context);
    this.userVm = UserViewModel(context);
    this.token = this.userVm.getToken();
    this.context = context;
  }

  Future<List<SearchHistoryModel>> getSearchHistories() async {
    var response = await searchHistoryService.getSearchHistories(token: token);
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
      showGLobalAlert('danger', 'Get Search Histories Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return [];
    }

    var result = GetSearchHistoriesResponseModel.fromJson(response);

    return result.histories;
  }

  Future<SearchHistoryModel?> createHistory({
    required String searchText
  }) async {
    var response = await searchHistoryService.createHistory(token: token, searchText: searchText);
    if (response == null) {
      showGLobalAlert('danger', 'Network Request Error', context);
      return null;
    }
    var check = userVm.isNotLoggedInCheck(response);
    if (check) {
      userVm.resetLocalDataAndBackToLogin();
      return null;
    }

    if (response.meta.code != 200) {
      showGLobalAlert('danger', 'Create Search History Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return null;
    }

    var searhHistory = SearchHistoryModel.fromJson(response.data['search']);
    return searhHistory;
  }

  Future<bool> deleteHistory({
    required int id
  }) async {
    var response = await searchHistoryService.deleteHistory(token: token, id: id);
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
      showGLobalAlert('danger', 'Delete Search History Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }
    
    showGLobalAlert('success', 'Delete History Success', context);
    return true;
  }

  Future<bool> clearHistories() async {
    var response = await searchHistoryService.clearHistories(token: token);
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
      showGLobalAlert('danger', 'Clear Search History Failed', context);
      if (response.meta.message is String) {
        showGLobalAlert('danger', response.meta.message, context);
      }
      return false;
    }

    showGLobalAlert('success', 'Berhasil Menghapus Riwayat Pencarian', context);
    return true;
  }
}