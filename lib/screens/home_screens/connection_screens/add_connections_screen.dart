import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/add_connection_tile.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/empty_list.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddConnections extends StatefulWidget {
  const AddConnections({super.key});

  @override
  State<AddConnections> createState() => _AddConnectionsState();
}

class _AddConnectionsState extends State<AddConnections> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final String title = 'Add Connections';
  final String svgFilePath = 'assets/svgs/freinds.svg';
  final String notFoundSvgFilePath = 'assets/svgs/user_not_found.svg';
  late final UsersCRUD usersCRUD;
  late UserModel foundUser;
  bool searching = false;
  bool userFound = false;
  bool initialState = true;
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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> searchUser() async {
    setState(() {
      searching = true;
      //
      if (initialState) {
        initialState = false;
      }
    });
    //
    dynamic result = await usersCRUD.getUsers(textController.text.trim());
    //
    if (result != null) {
      foundUser = result;
      userFound = true;
    } else {
      userFound = false;
    }
    //
    setState(() {
      searching = false;
    });
  }

  //
  Widget buildBody() {
    if (searching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    //
    if (initialState) {
      return Padding(
        padding: const EdgeInsets.all(spacing_24),
        child: EmptyList(
            svgFilePath: svgFilePath, message: 'Connect with travellers'),
      );
    }
    //
    if (!userFound) {
      return Padding(
        padding: const EdgeInsets.all(spacing_24),
        child: EmptyList(
            svgFilePath: notFoundSvgFilePath, message: 'No User Found!'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(spacing_8),
        child: AddConnectionTile(user: foundUser),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: darkOverlayStyle,
          title: Text(title),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          foregroundColor: green_10,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(spacing_24),
          child: ElevatedButtonWrapper(
            childWidget: ElevatedButton.icon(
              onPressed: () async {
                await searchUser();
              },
              icon: const Icon(Icons.search_outlined),
              label: const Text('Search'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(spacing_24),
                child: SearchBar(
                  controller: textController,
                  focusNode: focusNode,
                  hintText: 'Email',
                  search: (BuildContext context, String query) {},
                ),
              ),
              buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}
