import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;
import '../../show_event/show_event_page.dart';
import '../../../shared/exceptions/http_response_exception.dart';
import '../../../shared/models/event_model.dart';
import '../../../shared/repositories/event_repository.dart';
import '../../../shared/repositories/user_repository.dart';

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

  @observable
  bool isLoading = false;

  @action
  void addManyEvents(List<EventModel> list) {
    this.events.clear();
    this.events.addAll(list);
  }

  @action
  void setLoading(bool value) => this.isLoading = value;

  Future<void> getEvents() async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    await userRepository.logout();
    Navigator.popAndPushNamed(context, '');
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    getEvents();
  }

  void goToShowEventPage({EventModel? event}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowEventPage(eventModel: event),
      ),
    ).then((value) {
      getEvents();
    });
  }
}
