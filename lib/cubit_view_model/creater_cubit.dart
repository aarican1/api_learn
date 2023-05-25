import 'package:flutter_api_learn/cubit_view_model/creater_state.dart';
import 'package:flutter_api_learn/model/creater_model.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreaterCubit extends Cubit<CreaterState> {
  CreaterCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(CreaterState());
  final IReqresService _reqresService;

  Future<void> createrUserControl(String name, String job) async {
    emit(CreaterState(
        isLoading: true, createrModel: CreaterModel(name: name, job: job)));
    final response = await _reqresService.creater(CreaterModel(
        name: state.createrModel!.name, job: state.createrModel!.job));
    emit(CreaterState(isLoading: false, feedBackModel:response , isCompleted: response != null));
  }
}
