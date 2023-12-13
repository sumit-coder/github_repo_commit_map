import 'dart:math';

class Utility {
  //
  static int getMaxCommitCountOnSingleDay(dynamic weeklyCommits) {
    int maxCount = 0;

    for (var week in weeklyCommits) {
      for (var day in week['days']) {
        maxCount = max(maxCount, day as int);
      }
    }

    return maxCount;
  }

  // get Normalize Commit Counts form commit List
  static int normalizeCommitCounts(int currentCount, int minNormalize, int maxNormalize, int maxCount) {
    // int maxCount = commitCounts.reduce((value, element) => max(value, element));

    if (currentCount == 0) {
      // To avoid division by zero
      return 0;
    }
    // if 0 commits then return 0 to avoid returning 1
    if (currentCount == 1) return 1;
    double normalized = (currentCount / maxCount) * (maxNormalize - minNormalize);
    return normalized.round();
  }
}
