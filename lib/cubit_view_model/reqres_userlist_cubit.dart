import 'package:flutter_api_learn/cubit_view_model/reqres_userlist_state.dart';

import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/reqres_user_model.dart';

class ReqresUserListCubit extends Cubit<ReqresUserListState> {
  ReqresUserListCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(ReqresUserListState()) {
    myuserList();
  }
  final IReqresService _reqresService;

  Future<List<Data?>> myuserList() async {
    final response = (await _reqresService.userlist())?.data ?? [];
    emit(ReqresUserListState(data: response, isLoading: true));
    return response;
  }
}
