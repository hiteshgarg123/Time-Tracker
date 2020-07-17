import 'dart:ui';

import 'package:flutter/foundation.dart';

class Entry {
  Entry({
    @required this.id,
    @required this.jobId,
    @required this.start,
    @required this.end,
    this.comment,
  });

  String id;
  String jobId;
  DateTime start;
  DateTime end;
  String comment;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic> value, String id) {
    if (value == null) {
      return null;
    }
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Entry(
      id: id,
      jobId: value['jobId'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }

  @override
  int get hashCode => hashValues(id, jobId, start, end, comment);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    final Entry otherEntry = other;
    return id == otherEntry.id &&
        jobId == otherEntry.jobId &&
        start == otherEntry.start &&
        end == otherEntry.end &&
        comment == otherEntry.comment;
  }

  @override
  String toString() =>
      'id: $id , jobId: $jobId , start: $start , end: $end , comment: $comment';
}
