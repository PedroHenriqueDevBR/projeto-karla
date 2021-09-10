import '../models/event_model.dart';

abstract class IEventStorage {
  Future<EventModel> addEvent(EventModel event);

  Future<List<EventModel>> getAllEvents();

  Future<void> updateEvent(EventModel event);

  Future<void> deleteEvent(EventModel event);
}
