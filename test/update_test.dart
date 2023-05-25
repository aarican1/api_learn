import 'package:flutter_api_learn/model/creater_model.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IReqresService createService;
  setUp(() {
   createService = ReqresService(DioManager.instance);
  });
  test(ReqresService, () async{
    final response =
       await createService.updatePatch(CreaterModel(name: 'morpheus', job: 'zion resident'));
   final response2 =
       await createService.updatePut(CreaterModel(name: 'morpheus', job: 'zion resident'));
    expect(response,  isNotNull);
    expect(response2,  isNotNull);
  });
}