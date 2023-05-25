

import 'package:flutter_api_learn/cubit_view_model/login_state.dart';
import 'package:flutter_api_learn/model/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/reqres_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(LoginState());
  final IReqresService _reqresService;

  Future<void> checkUser(String email, String password) async {
    emit(LoginState(isLoading: true, model: LoginModel(email, password)));
   final response= await _reqresService.login(LoginModel(state.model!.email,state.model!.password));
    emit(LoginState(isLoading: false, isCompleted: (response != null)));
  }
 

  
}
