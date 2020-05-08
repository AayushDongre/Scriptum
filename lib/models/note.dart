import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class Note {
  File file;
  String title;
  List<String> tags;
  DateTime timeStamp;
  String comment;
  String content;

  Note({
    @required this.file,
    @required this.title,
    @required this.tags,
    @required this.timeStamp,
    this.comment,
    this.content,
  })  : assert(file != null),
        assert(title != null),
        assert(tags != null),
        assert(timeStamp != null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Note &&
      o.file == file &&
      o.title == title &&
      listEquals(o.tags, tags) &&
      o.timeStamp == timeStamp &&
      o.comment == comment &&
      o.content == content;
  }

  @override
  int get hashCode {
    return file.hashCode ^
      title.hashCode ^
      tags.hashCode ^
      timeStamp.hashCode ^
      comment.hashCode ^
      content.hashCode;
  }

  @override
  String toString() {
    return '''Note(
      file: $file, 
      title: $title, 
      tags: $tags, 
      timeStamp: $timeStamp, 
      comment: $comment, 
      content: $content)''';
  }
}
