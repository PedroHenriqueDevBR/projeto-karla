import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/exceptions/http_response_exception.dart';
import 'package:projeto_karla/src/shared/exceptions/invalid_data_exception.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:share/share.dart';

part 'show_event_store.g.dart';

class ShowEventStore extends _ShowEventStore with _$ShowEventStore {
  ShowEventStore({
    required BuildContext context,
    required EventRepository eventRepository,
    required UserRepository userRepository,
  }) {
    super.context = context;
    super.userRepository = userRepository;
    super.eventRepository = eventRepository;
  }
}

abstract class _ShowEventStore with Store {
  late BuildContext context;
  late EventRepository eventRepository;
  late UserRepository userRepository;
  final textTheme = AppTextTheme();
  final style = ShowEventStyle();
  // ===
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtConfirmText = TextEditingController();
  TextEditingController txtCancelText = TextEditingController();
  TextEditingController txtImageUrl = TextEditingController();
  TextEditingController txtPassword = TextEditingController(text: '1234');

  @observable
  bool editing = false;

  @observable
  String imageUrl = '';

  @observable
  EventModel event = EventModel.empty();

  @action
  void changeBackgroundImage() {
    if (!_imageIsValid(txtImageUrl.text)) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('A URL da imagem não é válida'));
      return;
    }
    this.imageUrl = txtImageUrl.text;
  }

  @action
  void toggleEdit() => editing = !editing;

  @action
  changeCurrentEvent(EventModel value) => this.event = value;

  void initEvent(EventModel? eventArg) {
    if (eventArg != null) {
      this.txtTitle.text = eventArg.title;
      this.txtDescription.text = eventArg.description;
      this.txtDate.text = eventArg.formatedDate;
      this.txtConfirmText.text = eventArg.confirmTextFormated;
      this.txtCancelText.text = eventArg.cancelTextFormated;
      this.imageUrl = eventArg.background ?? '';
      this.changeCurrentEvent(eventArg);
      event.responses.addAll(eventArg.responses);
      return;
    }
    this.toggleEdit();
  }

  bool _imageIsValid(String image) {
    if (!image.contains('http')) return false;
    return true;
  }

  void save() {
    if (this.event.id == null) {
      _registerEvent();
      return;
    }
    _updateEvent();
  }

  Future<void> _registerEvent() async {
    if (!_eventDataIsValid()) return;
    final splitedtextDate = txtDate.text.split('/');
    EventModel eventToRegister = EventModel(
      title: txtTitle.text,
      description: txtDescription.text,
      expirationDate: DateTime.parse('${splitedtextDate[2]}-${splitedtextDate[1]}-${splitedtextDate[0]} 00:00:00'),
      background: imageUrl.isNotEmpty ? imageUrl : null,
      confirmText: txtConfirmText.text.isNotEmpty ? txtConfirmText.text : null,
      cancelText: txtCancelText.text.isNotEmpty ? txtCancelText.text : null,
      password: txtPassword.text,
    );
    try {
      EventModel eventResponse = await eventRepository.addEvent(eventToRegister);
      event = eventResponse;
      _showMessage('Evento registrado com sucesso');
      this.toggleEdit();
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else if (error.response.statusCode == 401) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Sua sessão foi encerrada, entre novamente'));
        logout();
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('${error.response.statusCode} - Erro interno'));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _updateEvent() async {
    if (!_eventDataIsValid()) return;
    _setEventDataToUpdate();
    try {
      await eventRepository.updateEvent(event);
      _showMessage('Dados atualizados');
      this.toggleEdit();
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else if (error.response.statusCode == 401) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Sua sessão foi encerrada, entre novamente'));
        logout();
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('${error.response.statusCode} - Erro interno'));
      }
    } on InvalidDataException catch (error) {
      _showMessage(error.errors.toString());
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteEvent() async {
    if (event.id == null) {
      _showMessage('Evento não salvo, impossível deletar');
      return;
    }
    try {
      eventRepository.deleteEvent(event);
      _showMessage('Evento deletado');
      Navigator.pop(context);
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro 503 - Servidor indisponível'));
      } else if (error.response.statusCode == 401) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Sua sessão foi encerrada, entre novamente'));
        logout();
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('${error.response.statusCode} - Erro interno'));
      }
    } catch (error) {
      print(error);
    }
  }

  void _setEventDataToUpdate() {
    final splitedtextDate = txtDate.text.split('/');
    this.event.title = txtTitle.text;
    this.event.description = txtDescription.text;
    this.event.expirationDate = DateTime.parse(
      '${splitedtextDate[2]}-${splitedtextDate[1]}-${splitedtextDate[0]} 00:00:00',
    );
    this.event.background = imageUrl.isNotEmpty ? imageUrl : null;
    this.event.confirmText = txtConfirmText.text.isNotEmpty ? txtConfirmText.text : null;
    this.event.cancelText = txtCancelText.text.isNotEmpty ? txtCancelText.text : null;
    this.event.password = txtPassword.text;
  }

  Future<void> logout() async {
    await userRepository.logout();
    Navigator.popAndPushNamed(context, '');
  }

  bool _eventDataIsValid() {
    if (txtTitle.text.isEmpty) {
      _showMessage('Informe o titulo do evento');
      return false;
    } else if (txtDescription.text.isEmpty) {
      _showMessage('Informe a descrição do evento');
      return false;
    } else if (txtDescription.text.isEmpty) {
      _showMessage('Informe a senha para que o evento possa ser acessado');
      return false;
    }
    final splitedtextDate = txtDate.text.split('/');
    final convertedDate =
        DateTime.tryParse('${splitedtextDate[2]}-${splitedtextDate[1]}-${splitedtextDate[0]} 00:00:00');
    if (convertedDate == null) {
      _showMessage('A data informada não é válida');
      return false;
    }
    return true;
  }

  void _showMessage(String message) {
    asuka.showSnackBar(asuka.AsukaSnackbar.message(message));
  }

  void shareEvent() {
    if (event.id == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Evento não salvo no sistema'));
      return;
    }
    Share.share(
      'http://localhost:8000/evento/${event.id}/${event.title.replaceAll(' ', '')}',
      subject: 'Look what I made!',
    );
  }
}
