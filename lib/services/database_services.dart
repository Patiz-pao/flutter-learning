import 'dart:convert';

import 'package:flutter_learning/models/task.dart';
import 'package:flutter_learning/services/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DatabaseServices {
  static Future<Task> addTask(String task) async {
    if (task.trim().isEmpty) {
      throw Exception('Task title cannot be empty');
    }

    Map data = {
      'id': "1",
      'task': task.trim(),
    };
    
    var body = json.encode(data);
    var url = Uri.parse('$baseUrl/addTask');

    http.Response response = await http.post(url, headers: headers, body: body);

    developer.log(response.body);
    Map responseMap = jsonDecode(response.body);

    return Task.fromMap(responseMap);
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse('$baseUrl/getTask');
    http.Response response = await http.get(url, headers: headers);

    developer.log(response.body);
    Map responseMap = jsonDecode(response.body);
    
    if (responseMap['status'] == 'OK') {
      List data = responseMap['data'];
      return data.map((taskMap) => Task.fromMap(taskMap)).toList();
    } else {
      throw Exception('Failed to load tasks: ${responseMap['message']}');
    }
  }
}
