
import 'package:flutter_api_learn/cubit_view_model/resource_state.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/resource_model.dart';

class ResourceCubit extends Cubit<ResourceState> {
  final IReqresService _reqresService;
  ResourceCubit(ReqresService reqresService)
      : _reqresService = reqresService,
        super(ResourceState()) {
    resourceList();
  }

  Future<List<Data?>>? resourceList() async {
    final response = (await _reqresService.resource())?.data ?? [];
    emit(ResourceState(data: response));
    return response;
  }
}
