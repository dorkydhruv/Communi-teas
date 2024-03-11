import 'package:community_app/enums/date_sorting.dart';
import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments req) {
    if (req.sortByCreatedAt) {
      final sortedDoc = toList()
        ..sort((a, b) {
          switch (req.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDoc;
    } else {
      return this;
    }
  }
}
