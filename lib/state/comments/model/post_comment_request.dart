import 'package:community_app/enums/date_sorting.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class RequestForPostAndComments {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;
  const RequestForPostAndComments(
      {required this.postId,
      this.sortByCreatedAt = true,
      this.dateSorting = DateSorting.newestOnTop,
      this.limit});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestForPostAndComments &&
        other.postId == postId &&
        other.sortByCreatedAt == sortByCreatedAt &&
        other.dateSorting == dateSorting &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hashAll([
        postId,
        sortByCreatedAt,
        dateSorting,
        limit,
      ]);
}
