import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:whattosolve/models/solvedac_problem.dart';

class SolvedacService {
  static const String baseUrl = "https://solved.ac/api/v3";

  static Future<SolvedacProblem> getProblemWithFilter(String query) async {
    final url = Uri.parse('$baseUrl/search/problem?query=$query');
    final response = await http.get(url);

    // if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    int index = Random().nextInt(data['items'].length);
    return SolvedacProblem.fromJson(data['items'][index]);
    // }
    // return null;
  }
}
