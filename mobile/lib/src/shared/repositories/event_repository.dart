import 'dart:io';

import 'package:projeto_karla/src/shared/services/http_response_model.dart';

import '../interfaces/app_data_interface.dart';
import '../interfaces/client_http_interface.dart';
import '../models/event_model.dart';
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
    } on SocketException catch (error) {
      if (error.osError!.message.contains('Connection refused')) {
        return throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: 503,
            data: {},
            headers: {},
          ),
        );
      }
      return throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 400,
          data: {},
          headers: {},
        ),
      );
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
    } on SocketException catch (error) {
      if (error.osError!.message.contains('Connection refused')) {
        return throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: 503,
            data: {},
            headers: {},
          ),
        );
      }
      return throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 400,
          data: {},
          headers: {},
        ),
      );
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
    return errors;
  }
}
