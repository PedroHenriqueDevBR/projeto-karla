import '../models/event_model.dart';
import '../models/response_model.dart';

abstract class IResponseStorage {
  Future<ResponseModel> addResponse(ResponseModel responseModel, EventModel event);

  Future<List<ResponseModel>> getResponsesFromEvent(EventModel event);

  Future<void> deleteResponseFromEvent(ResponseModel responseModel, EventModel event);
}
