// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$addOrUpdateEventAsyncAction =
      AsyncAction('_HomeStore.addOrUpdateEvent');

  @override
  Future<void> addOrUpdateEvent(EventModel event) {
    return _$addOrUpdateEventAsyncAction
        .run(() => super.addOrUpdateEvent(event));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void addManyEvents(List<EventModel> list) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.addManyEvents');
    try {
      return super.addManyEvents(list);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}