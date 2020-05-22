import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/storage/storageRepository.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({Key key, this.note}) : super(key: key);
  DocumentSnapshot note;
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DocumentSnapshot note;
  User user;
  String url = '';

  @override
  void initState() {
    super.initState();
    note = widget.note;
    user = context.repository<AuthRepository>().currentUser;
    RepositoryProvider.of<StorageRepository>(context)
        .getNote(user, note)
        .then((value) {
      setState(() {
        url = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: h1(note['title'].toString().toUpperCase()),
            centerTitle: true,
            backgroundColor: appBarBackground,
            expandedHeight: 500,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(url),
              collapseMode: CollapseMode.parallax,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((builder, index) {
              String paragraph = note['content'][index];
              String lead = paragraph.split(' ')[0].toUpperCase();
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Text(paragraph + '\n\n', style: TextStyle(color: Colors.white70, fontSize: 18),),
              );
            }, childCount: note['content'].length),
          ),
        ],
      ),
    );
  }
}

//           SliverFixedExtentList(
//   itemExtent: 50,
//   delegate: SliverChildBuilderDelegate(
//     (BuildContext context, int index) {
//       return Container(
//         alignment: Alignment.center,
//         color: Colors.lightBlue[100 * (index % 9)],
//         child: Text('list item $index'),
//       );
//     },
//   ),
// ),
