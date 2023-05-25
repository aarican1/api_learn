import 'package:flutter_api_learn/cubit_view_model/delete_state.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(DeleteState());

  final IReqresService _reqresService;

  Future<bool> deleteControl() async {
    emit(DeleteState(isDelete: false));
    final response = await _reqresService.delete();
    if (response) {
      emit(DeleteState(isDelete: true));
      return response;
    }
    return false;
  }
}
