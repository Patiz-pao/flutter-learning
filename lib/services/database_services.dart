import 'dart:convert';
import 'package:flutter_learning/models/task.dart';
import 'package:flutter_learning/services/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DatabaseServices {

  static Future<Task> addTasks(String taskText) async {
    try {
      var url = Uri.parse('$baseUrl/addTask');
      developer.log('Sending task: $taskText');
      
      http.Response response = await http.post(
        url, 
        headers: headers, 
        body: jsonEncode({'task': taskText})
      );
      
      developer.log('Response body: ${response.body}');
      
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Task task = Task.fromMap(responseMap['data']);

      return task;
    } catch (e) {
      developer.log('Error adding task: $e');
      rethrow;
    }
  }

  static Future<bool> deleteTask(String taskId) async {
    try {
      var url = Uri.parse('$baseUrl/deleteTask').replace(
        queryParameters: {'id': taskId}
      );
      developer.log('Deleting task with URL: $url');
      
      http.Response response = await http.delete(
        url,
        headers: headers,
      );
      
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return responseMap['status'] == 'OK';
      } else {
        throw Exception('Failed to delete task: ${response.body}');
      }
    } catch (e) {
      developer.log('Error deleting task: $e');
      rethrow;
    }
  }

  static Future<List<Task>> getTasks() async {
    try {
      var url = Uri.parse('$baseUrl/getTask');
      http.Response response = await http.get(url, headers: headers);
      
      developer.log('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');
      
      Map<String, dynamic> responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> responseList = responseMap['data'] ?? [];
      
      List<Task> tasks = [];
      for (Map taskMap in responseList) {
        Task task = Task.fromMap(taskMap);
        tasks.add(task);
      }

      return tasks;
    } catch (e) {
      developer.log('Error parsing tasks: $e');
      rethrow;
    }
  }
}
