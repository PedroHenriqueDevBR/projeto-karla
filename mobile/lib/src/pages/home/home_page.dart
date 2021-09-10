import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'home_style.dart';
import 'stores/home_store.dart';
import 'widgets/event_card_widget.dart';
import '../../shared/core/assets.dart';
import '../../shared/models/event_model.dart';
import '../../shared/repositories/event_repository.dart';
import '../../shared/repositories/user_repository.dart';
import '../../shared/services/app_preferences_service.dart';
import '../../shared/services/http_client_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late HomeStore _store;
  AppAssets _assets = AppAssets();
  HomeStyle _style = HomeStyle();
  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _store = HomeStore(
      context: context,
      userStorage: UserRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
      eventStorage: EventRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
    );
    _store.getEvents();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposer = reaction(
      (_) => _store.events,
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Stack(
        children: [
          _contentWidget(),
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

  Widget _contentWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karla App'),
        actions: [
          TextButton(
            onPressed: _store.logout,
            child: Text(
              'Sair',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _store.refreshData,
        child: _store.events.length == 0
            ? Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nenhum evento para ser exibido',
                      style: _style.textStyleNothingToShow,
                    ),
                    SizedBox(height: 16.0),
                    OutlinedButton(
                      onPressed: _store.refreshData,
                      child: Text('Recarregar página'),
                      style: _style.btnRefreshDataStyle,
                    ),
                  ],
                ),
              )
            : Observer(
                builder: (_) => ListView.builder(
                  itemCount: _store.events.length,
                  itemBuilder: (_, index) {
                    EventModel event = _store.events[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EventCardWidget(
                        event: event,
                        onClick: () => _store.goToShowEventPage(event: event),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () => _store.goToShowEventPage(),
        label: Text('Evento'),
      ),
    );
  }
}
