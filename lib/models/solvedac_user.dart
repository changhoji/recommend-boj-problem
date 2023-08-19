class SolvedacUser {
  final String handle;
  final int tier;

  SolvedacUser.fromJson(Map<String, dynamic> data)
      : handle = data['handle'],
        tier = data['tier'];
}
