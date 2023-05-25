import 'package:flutter_api_learn/cubit_view_model/single_user_state.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/single_user_model.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  SingleUserCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(SingleUserState()) {
    myUser();
  }
  final IReqresService _reqresService;

  Future<Data?> myUser() async {
    final response = (await _reqresService.user())?.data ?? null;
    emit(SingleUserState(data: response));
    return response;
  }
}
