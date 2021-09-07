// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShowEventStore on _ShowEventStore, Store {
  final _$editingAtom = Atom(name: '_ShowEventStore.editing');

  @override
  bool get editing {
    _$editingAtom.reportRead();
    return super.editing;
  }

  @override
  set editing(bool value) {
    _$editingAtom.reportWrite(value, super.editing, () {
      super.editing = value;
    });
  }

  final _$imageUrlAtom = Atom(name: '_ShowEventStore.imageUrl');

  @override
  String get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ShowEventStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$eventAtom = Atom(name: '_ShowEventStore.event');

  @override
  EventModel get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(EventModel value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  final _$_ShowEventStoreActionController =
      ActionController(name: '_ShowEventStore');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ShowEventStoreActionController.startAction(
        name: '_ShowEventStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ShowEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBackgroundImage() {
    final _$actionInfo = _$_ShowEventStoreActionController.startAction(
        name: '_ShowEventStore.changeBackgroundImage');
    try {
      return super.changeBackgroundImage();
    } finally {
      _$_ShowEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleEdit() {
    final _$actionInfo = _$_ShowEventStoreActionController.startAction(
        name: '_ShowEventStore.toggleEdit');
    try {
      return super.toggleEdit();
    } finally {
      _$_ShowEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCurrentEvent(EventModel value) {
    final _$actionInfo = _$_ShowEventStoreActionController.startAction(
        name: '_ShowEventStore.changeCurrentEvent');
    try {
      return super.changeCurrentEvent(value);
    } finally {
      _$_ShowEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
editing: ${editing},
imageUrl: ${imageUrl},
isLoading: ${isLoading},
event: ${event}
    ''';
  }
}
