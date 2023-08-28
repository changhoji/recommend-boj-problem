import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/filter.dart';

class SolvedacService {
  static const String baseUrl = "https://solved.ac/api/v3";

  static const String hash = "%23";
  static const String or = "%7C";
  static const String and = "%26";
  static const String percent = "%25";

  static const List<Text> tiers = [
    Text('Ruby', style: TextStyle(color: Colors.red)),
    Text('Diamond', style: TextStyle(color: Colors.cyan)),
    Text('Platinum', style: TextStyle(color: Colors.green)),
    Text('Gold', style: TextStyle(color: Colors.orange)),
    Text('Silver', style: TextStyle(color: Colors.grey)),
    Text('Bronze', style: TextStyle(color: Colors.brown)),
  ];

  static dynamic problems;

  static Future<SolvedacProblem> getProblemWithFilter(Filter filter) async {
    if (!filter.searched) {
      print("re-search");
      String levelFilter = "*${filter.level}";
      String handleFilter =
          filter.handle != "" ? " $and !@${filter.handle}" : "";
      String tagFilter = "";
      for (var tag in filter.tags) {
        tagFilter = "$tagFilter$hash${tag.key}$or";
      }
      if (tagFilter != "") {
        tagFilter = tagFilter.substring(0, tagFilter.length - 3);
        tagFilter = " $and ($tagFilter)";
      }
      String translatedFilter = filter.translated ? " $and %ko" : "";

      String query = "$levelFilter$handleFilter$tagFilter$translatedFilter";
      print("query: $query");

      final url = Uri.parse('$baseUrl/search/problem?query=$query');
      final response = await http.get(url);

      // if (response.statusCode == 200) {
      problems = jsonDecode(response.body);
    }

    int index = Random().nextInt(problems['items'].length);
    return SolvedacProblem.fromJson(problems['items'][index]);
  }
}
