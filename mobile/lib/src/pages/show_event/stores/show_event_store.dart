import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:share/share.dart';
import 'package:asuka/asuka.dart' as asuka;
import '../show_event_style.dart';
import '../../../shared/core/app_text_theme.dart';
import '../../../shared/exceptions/http_response_exception.dart';
import '../../../shared/exceptions/invalid_data_exception.dart';
import '../../../shared/models/event_model.dart';
import '../../../shared/models/response_model.dart';
import '../../../shared/repositories/event_repository.dart';
import '../../../shared/repositories/response_repository.dart';
import '../../../shared/repositories/user_repository.dart';

part 'show_event_store.g.dart';

class ShowEventStore extends _ShowEventStore with _$ShowEventStore {
  ShowEventStore({
    required BuildContext context,
    required EventRepository eventRepository,
    required UserRepository userRepository,
    required ResponseRepository responseRepository,
  }) {
    super.context = context;
    super.userRepository = userRepository;
    super.eventRepository = eventRepository;
    super.responseRepository = responseRepository;
  }
}

abstract class _ShowEventStore with Store {
  late BuildContext context;
  late EventRepository eventRepository;
  late ResponseRepository responseRepository;
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
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtResponse = TextEditingController();

  @observable
  bool editing = false;

  @observable
  String imageUrl = '';

  @observable
  bool isLoading = false;

  @observable
  EventModel event = EventModel.empty();

  @action
  void setLoading(bool value) => this.isLoading = value;

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
      this.txtPassword.text = eventArg.password ?? '';
      this.imageUrl = eventArg.background ?? '';
      this.changeCurrentEvent(eventArg);
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
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> _updateEvent() async {
    if (!_eventDataIsValid()) return;
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteEvent() async {
    if (event.id == null) {
      _showMessage('Evento não salvo, impossível deletar');
      return;
    }
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> addResponse(bool confirm) async {
    if (event.id == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Não permitido\nmotivo: evento não salvo'));
      return;
    }
    if (!_eventDataIsValid()) return;
    setLoading(true);
    ResponseModel responseModel = ResponseModel.toSave(guestName: txtResponse.text, confirm: confirm);
    try {
      ResponseModel response = await responseRepository.addResponse(responseModel, event);
      this.event.responses.add(response);
      this.txtResponse.clear();
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Resposta adicionada com sucesso'));
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

  Future<void> removeResponse(ResponseModel responseModel) async {
    if (event.id == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Não permitido\nmotivo: evento não salvo'));
      return;
    }
    if (!_eventDataIsValid()) return;
    setLoading(true);
    try {
      await responseRepository.deleteResponseFromEvent(responseModel, event);
      this.event.responses.remove(responseModel);
      this.txtResponse.clear();
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Resposta removida com sucesso'));
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

  bool responseIsValidToSave() {
    if (txtResponse.text.length < 3) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Digite pelo 3 caracteres no nome do convidado'));
      return false;
    }
    return true;
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
      'Acesse o meu evento ${event.title} e utilize a senha ${event.password} ' +
          'para acessar e confirmar a sua presença.\n\n' +
          'http://localhost:8000/evento/${event.id}/${event.title.replaceAll(' ', '')}',
    );
  }
}
