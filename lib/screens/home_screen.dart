import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/constants/widgets/drawer.dart';
import 'package:scriptum/constants/widgets/folder.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/screens/datesScreen.dart';
import 'package:scriptum/screens/tagsScreen.dart';
import 'package:scriptum/screens/upload/upload_screen.dart';
import 'package:unicorndial/unicorndial.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  User user;
  TabController _tabController;
  final List<Tab> _tabs = <Tab>[Tab(text: 'Tags'), Tab(text: 'Date')];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    user = context.repository<AuthRepository>().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:drawer(context),
      appBar: AppBar(
        title: h1('HOME'),
        bottom: TabBar(tabs: _tabs, controller: _tabController),
        backgroundColor: appBarBackground,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            color: backgroundColor,
            child: StreamBuilder(
              stream: context.repository<DBRepository>().getUserDetails(user),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  List tags = snapshot.data.data['tags'] ?? [];
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: tags.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: folder(tags[index]),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TagScreen(
                              tag: tags[index],
                              dbRepository: context.repository<DBRepository>(),
                              user: user,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // ************************
          Container(
            color: backgroundColor,
            child: StreamBuilder(
              stream: context.repository<DBRepository>().getUserDetails(user),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  List dates = snapshot.data.data['dates'] ?? [];

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: dates.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: folder(timestampToString(dates[index])),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DateScreen(
                                    dbRepository:
                                        context.repository<DBRepository>(),
                                    date: dates[index].toDate(),
                                    user: user,
                                  )),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
        parentButton: Icon(
          Icons.add,
          color: Colors.white,
        ),
        childPadding: 20,
        orientation: UnicornOrientation.VERTICAL,
        childButtons: [
          UnicornButton(
            labelText: 'Camera',
            currentButton: FloatingActionButton(
              mini: true,
              onPressed: () async {
                File file =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                if (file != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadScreen(file: file)),
                  );
                }
              },
              heroTag: 'Camera',
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
          UnicornButton(
            labelText: 'Gallery',
            currentButton: FloatingActionButton(
              mini: true,
              onPressed: () async {
                File file =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadScreen(file: file),
                    ),
                  );
                }
              },
              child: Icon(Icons.photo_library, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String timestampToString(timestamp) {
    DateTime date = timestamp.toDate();
    String dateStr = '${date.day}/${date.month}/${date.year}';
    return dateStr;
  }
}
