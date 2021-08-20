@Skip()
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';
import 'package:projeto_karla/src/shared/services/http_response_model.dart';

main() {
  test('Should be a HttpResponseModel', () async {
    HTTPClientService httpClient = HTTPClientService();
    var response = await httpClient.get('/api/v1/events/show/2');
    expect(response, isA<HttpResponseModel>());
    expect(response.statusCode, equals(200));
  });
}
