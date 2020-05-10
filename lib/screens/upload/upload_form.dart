import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/widgets.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/storage/storageRepository.dart';
import 'package:scriptum/uploadBloc/upload_bloc.dart';

class UploadForm extends StatefulWidget {
  final File file;

  UploadForm({
    Key key,
    @required this.file,
  }) : super(key: key);

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
                  standardTextInput(
                    hintText: 'Tags',
                    controller: _tagsController,
                    validator: (value) => null,
                  ),
                  button(
                    context,
                    'Upload',
                    onTap: () {
                      if (_titleController.text.isNotEmpty) {
                        _uploadBloc.add(
                          UploadSubmitted(
                            note: Note(
                                uid: user.uid,
                                file: widget.file,
                                title: _titleController.text,
                                tags: ['maths', 'important'],
                                timeStamp: DateTime.now(),
                                comment: _commentController.text),
                          ),
                        );
                        Scaffold.of(context)
                          ..showSnackBar(snackbar(snackBarMessage, Icons.info));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _blocListner(BuildContext context, UploadState state) {
    if (state.isEtractingText) {
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
      Scaffold.of(context)..hideCurrentSnackBar();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _tagsController.dispose();
    _titleController.dispose();
    _tagsController.dispose();
    _uploadBloc.close();
    super.dispose();
  }
}
