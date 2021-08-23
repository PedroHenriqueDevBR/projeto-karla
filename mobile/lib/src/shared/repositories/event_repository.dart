import '../services/app_data_interface.dart';
import '../models/event_model.dart';
import '../services/client_http_interface.dart';
import '../exceptions/http_response_exception.dart';
import '../exceptions/invalid_data_exception.dart';

class EventRepository {
  IClientHTTP _client;
  IAppData _appData;

  EventRepository({required IClientHTTP client, required IAppData appData})
      : this._client = client,
        this._appData = appData;

  Future<EventModel> addEvent(EventModel event) async {
    final errors = _validToSaveOrErrors(event);
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.post(url, event.toMap(), jwtKey: jwt);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return EventModel.fromRestAPI(response.data);
      }
      throw HttpResponseException(response: response);
    } catch (error) {
      throw error;
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    String url = 'v1/events';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.get(url, jwtKey: jwt);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return EventModel.fromResponseList(response.data);
      }
      throw HttpResponseException(response: response);
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateEvent(EventModel event) async {
    final errors = _validToSaveOrErrors(event);
    errors.addAll(_validToUpdateOrErrors(event));
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events/${event.id}';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.put(url, event.toMap(), jwtKey: jwt);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpResponseException(response: response);
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteEvent(EventModel event) async {
    final errors = _validToUpdateOrErrors(event);
    if (errors.isNotEmpty) throw InvalidDataException(errors: errors);
    String url = 'v1/events/${event.id}';
    String jwt = await _appData.getJWT();
    try {
      final response = await _client.delete(url, jwtKey: jwt);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpResponseException(response: response);
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  List<String> _validToUpdateOrErrors(EventModel event) {
    List<String> errors = [];
    if (event.id == null) errors.add('Impossível modificar evento sem ID');
    return errors;
  }

  List<String> _validToSaveOrErrors(EventModel event) {
    List<String> errors = [];
    if (event.title.isEmpty) errors.add('Titulo não pode ser vazio');
    if (event.expirationDate.compareTo(DateTime.now()) < 0) {
      errors.add('A data deve ser posterior ao dia atual');
    }
    return errors;
  }
}
