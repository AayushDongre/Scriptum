import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/constants/widgets/listCard.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';

class TagScreen extends StatefulWidget {
  final String tag;
  final DBRepository dbRepository;
  final User user;

  TagScreen({
    Key key,
    @required this.tag,
    @required this.dbRepository,
    @required this.user,
  })  : assert(dbRepository != null),
        assert(user != null),
        super(key: key);

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  DBRepository _dbRepository;
  String tag;
  User _user;
  bool descending;

  @override
  void initState() {
    super.initState();
    _dbRepository = widget.dbRepository;
    tag = widget.tag;
    _user = widget.user;
    descending = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1(tag.toUpperCase()),
        centerTitle: true,
        backgroundColor: appBarBackground,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.sort,
                size: 24,
              ),
            ),
            onTap: () {
              setState(() {
                descending = !descending;
              });
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder(
        stream: _dbRepository.getNotesFromTag(tag, _user.uid,
            descending: descending),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            List<DocumentSnapshot> documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot document = documents[index];
                return ListCard(document: document);
              },
            );
          }
        },
      ),
    );
  }
}
