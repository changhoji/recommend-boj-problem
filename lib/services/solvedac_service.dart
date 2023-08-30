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

  static Text levelToText(int level) {
    return Text(
      "${tiers[5 - (level - 1) ~/ 5].data}${5 - (level - 1) % 5}",
      style: tiers[5 - (level - 1) ~/ 5].style,
    );
  }

  static Future<SolvedacProblem> getProblemWithFilter(Filter filter) async {
    if (!filter.searched) {
      String levelFilter =
          "*${filter.level.start.round()}..${filter.level.end.round()}";
      String handleFilter =
          filter.handle != "" ? " $and !@${filter.handle}" : "";

      String containTagFilter = "";
      for (var tag in filter.containTags) {
        containTagFilter = "$containTagFilter$hash${tag.key}$or";
      }
      if (containTagFilter != "") {
        containTagFilter =
            containTagFilter.substring(0, containTagFilter.length - 3);
        containTagFilter = " $and ($containTagFilter)";
      }
      String translatedFilter = filter.translated ? " $and %ko" : "";

      String exceptTagFilter = "";
      for (var tag in filter.exceptTags) {
        exceptTagFilter = "$exceptTagFilter!$hash${tag.key}$and";
      }
      if (exceptTagFilter != "") {
        exceptTagFilter =
            exceptTagFilter.substring(0, exceptTagFilter.length - 3);
        exceptTagFilter = " $and ($exceptTagFilter)";
      }

      String query =
          "$levelFilter$handleFilter$containTagFilter$exceptTagFilter$translatedFilter";

      final url = Uri.parse(
          'https://api-py.vercel.app/https:~~solved.ac~api~v3~search~problem\$query=$query');
      // final response = await http.get(url);
      final response = await http.get(url);

      // if (response.statusCode == 200) {
      problems = jsonDecode(response.body);
    }

    int index = Random().nextInt(problems['items'].length);
    return SolvedacProblem.fromJson(problems['items'][index]);
  }

  static Future<bool> isExistingHandle(String handle) async {
    var url = Uri.parse(
        "https://api-py.vercel.app/https:~~solved.ac~api~v3~user~show\$handle=$handle");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
