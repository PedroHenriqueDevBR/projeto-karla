import '../interfaces/app_data_interface.dart';
import '../interfaces/client_http_interface.dart';
import '../exceptions/http_response_exception.dart';
import '../exceptions/invalid_data_exception.dart';
import '../models/event_model.dart';
import '../models/response_model.dart';

class ResponseRepository {
  IClientHTTP _client;
  IAppData _appData;

  ResponseRepository({required IClientHTTP client, required IAppData appData})
      : this._client = client,
        this._appData = appData;

  Future<ResponseModel> addResponse(ResponseModel responseModel, EventModel event) async {
    final errors = _validToSaveOrErrors(responseModel);
    errors.addAll(_isEventValidOrErrors(event));
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events/${event.id}/responses/add';
    try {
      final response = await _client.post(url, responseModel.toMap());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        responseModel.id = response.data['id'];
        return responseModel;
      }
      throw HttpResponseException(response: response);
    } catch (error) {
      throw error;
    }
  }

  Future<List<ResponseModel>> getResponsesFromEvent(EventModel event) async {
    final errors = _isEventValidOrErrors(event);
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events/${event.id}/responses';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.get(url, jwtKey: jwt);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromResponseList(response.data);
      }
      throw HttpResponseException(response: response);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteResponseFromEvent(ResponseModel responseModel, EventModel event) async {
    final errors = _isEventValidOrErrors(event);
    errors.addAll(_isResponseValidOrErrors(responseModel));
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events/${event.id}/responses/del/${responseModel.id}';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.delete(url, jwtKey: jwt);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpResponseException(response: response);
      }
    } catch (error) {
      throw error;
    }
  }

  List<String> _isEventValidOrErrors(EventModel event) {
    List<String> errors = [];
    if (event.id == null) errors.add('O evento precisa ser salvo antes de adicionar respostas');
    return errors;
  }

  List<String> _isResponseValidOrErrors(ResponseModel responseModel) {
    List<String> errors = [];
    if (responseModel.id == null) errors.add('A resposta precisa ser salva antes de deletar');
    return errors;
  }

  List<String> _validToSaveOrErrors(ResponseModel response) {
    List<String> errors = [];
    if (response.guestName.isEmpty) errors.add('Nome não pode ser vazio');
    return errors;
  }
}
