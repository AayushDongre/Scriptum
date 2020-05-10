import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';

class TagScreen extends StatelessWidget {
  final DBRepository _dbRepository;
  final String tag;
  final User _user;
  TagScreen({
    Key key,
    @required this.tag,
    @required DBRepository dbRepository,
    @required User user,
  })  : assert(dbRepository != null),
        assert(user != null),
        _user = user,
        _dbRepository = dbRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1(tag.toUpperCase()),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder(
        stream: _dbRepository.getNotesFromTag(tag, _user.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            List<DocumentSnapshot> documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(documents[index].data['title']);
              },
            );
          }
        },
      ),
    );
  }
}
