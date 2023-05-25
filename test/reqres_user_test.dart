import 'package:flutter_api_learn/cubit_view_model/reqres_userlist_cubit.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
//late IReqresService registerService;
  late ReqresUserListCubit reqresUserListCubit;
  setUp(() {
  //  registerService = ReqresService(DioManager.instance);
    reqresUserListCubit =
        ReqresUserListCubit(ReqresService(DioManager.instance));
  });
  test(ReqresService, () async {
    final response = await reqresUserListCubit.myuserList();

    print(response);
    expect(response, isNotNull);
  });
}
