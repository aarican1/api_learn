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
       await createService.creater(CreaterModel(name: 'morpheus', job: 'leader'));
    print(response?.createdAt);
    expect(response,  isNotNull);
  });
}