import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/constants/widgets/listCard.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';

class DateScreen extends StatefulWidget {
  final DateTime date;
  final DBRepository dbRepository;
  final User user;

  DateScreen({
    Key key,
    @required this.date,
    @required this.dbRepository,
    @required this.user,
  })  : assert(dbRepository != null),
        assert(user != null),
        super(key: key);

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DBRepository _dbRepository;
  DateTime date;
  User _user;

  @override
  void initState() {
    super.initState();
    _dbRepository = widget.dbRepository;
    date = widget.date;
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1(DateFormat.yMMMd().format(date)),
        centerTitle: true,
        backgroundColor: appBarBackground,
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder(
        stream: _dbRepository.getNotesFromDate(date, _user.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            List<DocumentSnapshot> documents = snapshot.data.documents ?? [];
            return ListView.builder(
              itemCount: documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot document = documents[index];
                return ListCard(document: document,);
              },
            );
          }
        },
      ),
    );
  }
}
