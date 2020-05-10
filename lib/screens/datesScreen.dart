import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';

class DatesScreen extends StatelessWidget {
  final DBRepository _dbRepository;
  final DateTime date;
  final User _user;
  DatesScreen({
    Key key,
    @required this.date,
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
        title: h1(date.day.toString() + '/' + date.month.toString()),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder(
        stream: _dbRepository.getNotesFromDate(date, _user.uid),
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
