import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore {
  HomeStore({
    required UserRepository userRepository,
    required EventRepository repository,
  }) {
    super.userRepository = userRepository;
    super.eventRepository = repository;
  }
}

abstract class _HomeStore with Store {
  ObservableList<EventModel> events = ObservableList<EventModel>();
  late EventRepository eventRepository;
  late UserRepository userRepository;

  @action
  void addManyEvents(List<EventModel> list) {
    this.events.addAll(list);
  }

  Future<void> getEvents() async {
    try {
      List<EventModel> eventsResponse = await eventRepository.getAllEvents();
      addManyEvents(eventsResponse);
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('${error.response.statusCode} - Erro interno'));
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await userRepository.logout();
    Navigator.popAndPushNamed(context, '');
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    getEvents();
  }
}
