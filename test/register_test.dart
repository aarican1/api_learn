import 'package:flutter_api_learn/model/register_model.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IReqresService registerService;
  setUp(() {
   registerService = ReqresService(DioManager.instance);
  });
  test(ReqresService, () async{
    final response =await registerService.register(RegisterModel( 'eve.holt@reqres.in','pistol',));
      
    print(response.toString());
    expect(response, isNotNull);
  });
}