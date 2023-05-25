import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IReqresService deleteService;
  setUp(() {
    deleteService = ReqresService(DioManager.instance);
  });
  test(ReqresService, () async {
    final response = await deleteService.delete();
    expect(response, isNotNull);
  });
}
