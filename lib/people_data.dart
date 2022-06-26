import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<People> getPeople() async {
  String url = Uri.encodeFull('https://swapi.dev/api/people');

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    log("Fetch People");
    return People.fromJson(jsonDecode(response.body)["results"]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class People {
  final List<String> name;

  People({
    required this.name,
  });

  factory People.fromJson(List<dynamic> json) {
    List<String> listOfName = [];

    for (Map<String, dynamic> jsonData in json) {
      listOfName.add(jsonData["name"]);
    }

    return People(
      name: listOfName,
    );
  }
}
