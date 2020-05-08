import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scriptum/models/note.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  @override
  UploadState get initialState => UploadInitial();

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
