import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/constants/widgets/button.dart';
import 'package:scriptum/constants/widgets/snackbar.dart';
import 'package:scriptum/constants/widgets/standardTextInput.dart';
import 'package:scriptum/constants/widgets/tags.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/storage/storageRepository.dart';
import 'package:scriptum/uploadBloc/upload_bloc.dart';

class UploadForm extends StatefulWidget {
  final File file;
  final Function(String, BuildContext) callbackState;
  final Function() popPage;

  UploadForm(
      {Key key,
      @required this.file,
      @required this.callbackState,
      this.popPage})
      : super(key: key);

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  UploadBloc _uploadBloc;
  String snackBarMessage;
  User user;
  List<String> imageTags = [];

  @override
  void initState() {
    super.initState();
    snackBarMessage = 'Extracting Text';
    user = context.repository<AuthRepository>().currentUser;
    _uploadBloc = UploadBloc(
      dbRepository: context.repository<DBRepository>(),
      storageRepository: context.repository<StorageRepository>(),
      user: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _uploadBloc,
        listener: _blocListner,
        child: BlocBuilder(
            bloc: _uploadBloc,
            builder: (BuildContext context, UploadState state) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Form(
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      standardTextInput(
                        hintText: 'Title',
                        controller: _titleController,
                        validator: (value) =>
                            value.isEmpty ? 'Please Enter a title' : null,
                      ),
                      standardTextInput(
                        hintText: 'Comment(optional)',
                        controller: _commentController,
                        validator: (value) => null,
                      ),
                      Container(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            standardTextInput(
                              hintText: 'Tags',
                              controller: _tagsController,
                              validator: (value) => null,
                            ),
                            OutlineGradientButton(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.navigate_next),
                              strokeWidth: 2,
                              gradient: LinearGradient(
                                  colors: GradientColors.lightBlack),
                              onTap: () async {
                                widget.callbackState(
                                    _tagsController.text, context);
                                context
                                    .repository<DBRepository>()
                                    .addTag(user, _tagsController.text);
                                imageTags.add(_tagsController.text);
                                _tagsController.clear();
                              },
                            )
                          ],
                        ),
                      ),
                      button(
                        context,
                        'Upload',
                        onTap: () {
                          print(imageTags);
                          if (_titleController.text.isNotEmpty &&
                              imageTags.isNotEmpty) {
                            _uploadBloc.add(
                              UploadSubmitted(
                                note: Note(
                                    uid: user.uid,
                                    file: widget.file,
                                    title: _titleController.text,
                                    tags: imageTags,
                                    timeStamp: DateTime.now(),
                                    comment: _commentController.text),
                              ),
                            );
                          }
                        },
                      ),
                      Text(
                        'Your Tags:',
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                          letterSpacing: -0.4,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StreamBuilder(
                        stream: context
                            .repository<DBRepository>()
                            .getUserDetails(user),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              color: Colors.white,
                            );
                          } else {
                            List tags = snapshot.data.data['tags'];
                            return Container(
                              margin: EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width * .9,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                children: tags == null
                                    ? [Container()]
                                    : tags
                                        .map(
                                          (tag) => GestureDetector(
                                            child: noteTag(tag: tag),
                                            onTap: () {
                                              widget.callbackState(
                                                  tag, context);
                                              if (!imageTags.contains(tag)) {
                                                imageTags.add(tag);
                                              } else {
                                                imageTags.remove(tag);
                                              }
                                            },
                                          ),
                                        )
                                        .toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  void _blocListner(BuildContext context, UploadState state) {
    if (state.isEtractingText) {
      Scaffold.of(context)..showSnackBar(snackbar(snackBarMessage, Icons.info));
      setState(() {
        snackBarMessage = 'Extracting Text';
      });
    }
    if (state.isUploadingData) {
      setState(() {
        snackBarMessage = 'Working Magic';
      });
    }
    if (state.isUploadingToStorage) {
      setState(() {
        snackBarMessage = 'Uploading Data';
      });
    }
    if (state.isFailure) {
      setState(() {
        snackBarMessage = 'Something Went Wrong!';
      });
    }
    if (state.isSuccess) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('snackBarMessage', Icons.cached));
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  void dispose() {
    _tagsController.dispose();
    _titleController.dispose();
    _commentController.dispose();
    _uploadBloc.close();
    super.dispose();
  }
}
