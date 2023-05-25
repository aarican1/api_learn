import 'package:flutter_api_learn/model/login_model.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';

import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IReqresService loginService;
  setUp(() {
    loginService = ReqresService(DioManager.instance);
  });
  test(ReqresService, () async{
    final response =
       await loginService.login(LoginModel('eve.holt@reqres.in', 'cityslicka'));
    print(response.toString());
    expect(response, isNotNull);
  });
}
