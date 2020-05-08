part of 'upload_bloc.dart';

@immutable
abstract class UploadEvent extends Equatable {
  const UploadEvent();
}


class AddTag extends UploadEvent {
  final String tag;

  const AddTag({@required this.tag});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddTag(tag: $tag)';
}

class UploadSubmitted extends UploadEvent {
  final Note note;

  const UploadSubmitted({@required this.note});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UploadSubmitted(note: $note)';
}
