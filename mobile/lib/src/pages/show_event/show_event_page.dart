import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'stores/show_event_store.dart';
import 'widgets/bottom_button_widget.dart';
import 'widgets/bottom_navigation_widget.dart';
import 'widgets/event_content_widget.dart';
import 'widgets/event_form_widget.dart';
import 'widgets/header_widget.dart';
import '../../shared/models/event_model.dart';
import '../../shared/repositories/event_repository.dart';
import '../../shared/repositories/response_repository.dart';
import '../../shared/repositories/user_repository.dart';
import '../../shared/services/app_preferences_service.dart';
import '../../shared/services/http_client_service.dart';

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  late ShowEventStore _store;
  final formKey = GlobalKey<FormState>();
  late ReactionDisposer _disposer;

  @override
  void initState() {
    this._store = ShowEventStore(
      context: context,
      userRepository: UserRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
      eventRepository: EventRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
      responseRepository: ResponseRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
    );
    _store.initEvent(widget.eventModel);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposer = reaction(
      (_) => _store.event,
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Stack(
        children: [
          _contentPage(),
          _store.isLoading ? _loadingWidget(size) : Container(),
        ],
      ),
    );
  }

  Widget _loadingWidget(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black.withAlpha(100),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'carregando...',
              style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _contentPage() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Observer(
                builder: (context) => HeaderWidget(
                  imageUrl: _store.imageUrl,
                  txtTitle: _store.txtTitle,
                  txtImage: _store.txtImageUrl,
                  edit: _store.editing,
                  onSaveImage: _store.changeBackgroundImage,
                  onShare: _store.shareEvent,
                ),
              ),
              Observer(
                builder: (context) => _store.editing
                    ? EventFormWidget(
                        txtDescription: _store.txtDescription,
                        txtConfirmText: _store.txtConfirmText,
                        txtCancelText: _store.txtCancelText,
                        txtDate: _store.txtDate,
                        txtPassword: _store.txtPassword,
                        onCancel: _store.toggleEdit,
                        onDelete: _store.deleteEvent,
                        isSaved: _store.event.id != null,
                      )
                    : EventContentWidget(
                        eventModel: _store.event,
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => _store.editing
            ? BottomButtonWidget(onClick: () {
                if (formKey.currentState!.validate()) {
                  _store.save();
                }
              })
            : BottomNavigationWidget(
                txtResponse: _store.txtResponse,
                eventModel: _store.event,
                editOption: _store.toggleEdit,
                onConfirmResponse: _store.addResponse,
                onDeleteResponse: _store.removeResponse,
              ),
      ),
    );
  }
}
