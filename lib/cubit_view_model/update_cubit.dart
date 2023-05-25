import 'package:flutter_api_learn/cubit_view_model/update_state.dart';
import 'package:flutter_api_learn/model/creater_model.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(UpdateState());
  final IReqresService _reqresService;

  Future<void> updateWPutContoller(String name, String job) async {
    emit(UpdateState(
      isLoadingPut: true,
    ));
    final response =
        await _reqresService.updatePut(CreaterModel(name: name, job: job));
    if (response != null) {
      emit(UpdateState(
          isLoadingPut: false,
          feedBackModel: response.UpdatedAt,
          isUpdatePut: true));
    }
  }

  Future<void> updateWPatchContoller(String name, String job) async {
    emit(UpdateState(
      isLoadingPacth: true,
    ));
    final response =
        await _reqresService.updatePatch(CreaterModel(name: name, job: job));
    if (response != null) {
      emit(UpdateState(
          isLoadingPacth: false,
          feedBackModel: response.UpdatedAt,
          isUpdatePatch: true));
    }
  }
}
