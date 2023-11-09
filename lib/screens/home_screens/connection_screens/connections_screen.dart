import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/blocs/connections_bloc/connections_bloc.dart';
import 'package:tripplanner/business_logic/blocs/invitations_bloc/invitations_bloc.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/add_connections_screen.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/connections.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/requests.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  String title = 'Connections';
  late final UsersCRUD usersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
  }

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConnectionsBloc>(
            create: (context) => ConnectionsBloc(usersCRUD),
          ),
          BlocProvider<InvitationsBloc>(
            create: (context) => InvitationsBloc(usersCRUD),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: darkOverlayStyle,
            backgroundColor: Colors.transparent,
            foregroundColor: green_10,
            elevation: 0.0,
            title: Text(title),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: green_10,
              labelColor: green_10,
              indicatorWeight: 3.0,
              onTap: (value) {
                setState(() {
                  if (value == 0) {
                    title = 'Connections';
                  } else if (value == 1) {
                    title = 'Invitations';
                  }
                });
              },
              tabs: const <Widget>[
                Tab(
                  icon: Icon(Icons.people_alt_outlined),
                ),
                Tab(
                  icon: Icon(Icons.send_outlined),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddConnections(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder<bool?>(
              stream: TripsCRUD().userDataStream,
              builder: (context, snapshot) {
                //
                if (snapshot.hasData) {
                  BlocProvider.of<ConnectionsBloc>(context)
                      .add(LoadConnections());
                  //
                  BlocProvider.of<InvitationsBloc>(context)
                      .add(LoadInvitations());
                }
                //
                return const TabBarView(
                  children: [
                    Connections(),
                    Requests(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
