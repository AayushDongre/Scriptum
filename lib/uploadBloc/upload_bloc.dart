import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:meta/meta.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/note.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/storage/storageRepository.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  DBRepository _dbRepository;
  StorageRepository _storageRepository;
  User _user;

  UploadBloc({
    @required User user,
    @required DBRepository dbRepository,
    @required StorageRepository storageRepository,
  })  : assert(user != null),
        assert(dbRepository != null),
        assert(storageRepository != null),
        _dbRepository = dbRepository,
        _storageRepository = storageRepository,
        _user = user;

  @override
  UploadState get initialState => UploadState.initial();

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is AddTag) {
      yield* mapAddTagToState(event.tag);
    }
    if (event is UploadSubmitted) {
      yield* mapUploadSubmittedToState(event.note);
    }
  }

  Stream<UploadState> mapAddTagToState(String tag) async* {
    try {
      await _dbRepository.addTag(_user, tag);
      yield state;
    } catch (e) {
      print(e);
    }
  }

  Stream<UploadState> mapUploadSubmittedToState(Note note) async* {
    try {
      yield UploadState.extractingText();
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(note.file);
      final TextRecognizer textRecognizer =
          FirebaseVision.instance.textRecognizer();
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);
      String content = visionText.text;
      note.content = content;

      yield UploadState.uploadingToStorage();
      await _storageRepository.uploadNote(_user, note);

      yield UploadState.uploadingData();
      await _dbRepository.uploadNoteData(_user, note);
      await _dbRepository.addTags(_user, note.tags, note.timeStamp);

      yield UploadState.success();
    } catch (e) {
      print(e);
      yield UploadState.failure();
    }
  }
}
