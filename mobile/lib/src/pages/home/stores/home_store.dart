import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_page.dart';
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
    required BuildContext context,
  }) {
    super.userRepository = userRepository;
    super.eventRepository = repository;
    super.context = context;
  }
}

abstract class _HomeStore with Store {
  ObservableList<EventModel> events = ObservableList<EventModel>();
  late EventRepository eventRepository;
  late UserRepository userRepository;
  late BuildContext context;

  @action
  void addManyEvents(List<EventModel> list) {
    this.events.clear();
    this.events.addAll(list);
  }

  Future<void> getEvents() async {
    try {
      List<EventModel> eventsResponse = await eventRepository.getAllEvents();
      addManyEvents(eventsResponse);
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else if (error.response.statusCode == 401) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Sua sessão foi encerrada, entre novamente'));
        logout();
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('${error.response.statusCode} - Erro interno'));
      }
    }
  }

  @action
  Future<void> addOrUpdateEvent(EventModel event) async {
    if (event.id != null) {
      int index = events.indexWhere((element) => element.id == event.id);
      if (index != -1) events[index] = event;
      return;
    }
    getEvents();
  }

  Future<void> logout() async {
    await userRepository.logout();
    Navigator.popAndPushNamed(context, '');
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    getEvents();
  }

  void goToShowEventPage(EventModel event) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowEventPage(eventModel: event),
      ),
    ).then((value) {
      if (value != null) {
        if (value.runtimeType == EventModel) {
          EventModel event = value as EventModel;
          addOrUpdateEvent(event);
        }
        getEvents();
      }
    });
  }
}
