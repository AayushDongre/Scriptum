import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
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
              child: Icon(Icons.sort, size: 24,),
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
                DateTime date = document['timestamp'].toDate();
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    decoration:
                        BoxDecoration(color: backgroundColor.withOpacity(0.8)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: Icon(Icons.autorenew, color: Colors.white),
                      ),
                      title: Text(
                        document['title'].toString().toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.date_range,
                              color: Colors.yellow[300], size: 16),
                          Text('${date.day}/${date.month}/${date.year}',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
