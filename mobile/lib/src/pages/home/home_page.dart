import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/pages/home/home_style.dart';
import 'package:projeto_karla/src/pages/home/stores/home_store.dart';
import 'package:projeto_karla/src/pages/home/widgets/event_card_widget.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/app_preferences_service.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';

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
      userRepository: UserRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
      repository: EventRepository(
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
      (_) => _store.events.length,
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => _store.isLoading ? _loadingWidget() : _contentWidget(),
    );
  }

  Scaffold _loadingWidget() {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withGreen(100),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(_assets.player),
            SizedBox(height: 8.0),
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
