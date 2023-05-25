import 'package:flutter_api_learn/cubit_view_model/register_state.dart';
import 'package:flutter_api_learn/model/register_model.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(RegisterState());
  final IReqresService _reqresService;
  Future<void> RegisterUser(String email, String password) async {

    emit(RegisterState(isLoading: true, model: RegisterModel(email, password)));

    final response = await _reqresService
        .register(RegisterModel(state.model!.email, state.model!.password));
        
    emit(RegisterState(isLoading: false, isCompleted: response != null));
    
  }
}
