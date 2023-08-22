class SolvedacProblem {
  final int problemId;
  final String titleKo;
  final int level;

  SolvedacProblem.fromJson(Map<String, dynamic> data)
      : problemId = data['problemId'],
        titleKo = data['titleKo'],
        level = data['level'];
}
