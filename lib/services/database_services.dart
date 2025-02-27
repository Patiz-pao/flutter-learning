import 'dart:convert';
import 'package:flutter_learning/models/list_book.dart';
import 'package:flutter_learning/services/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class DatabaseServices {
  static Future<List<ListBook>> getBooks() async {
    var url = Uri.parse('$baseUrl/books');
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(utf8.decode(response.bodyBytes));

      developer.log(responseMap.toString());
      if (responseMap['status'] == 'OK') {
        List<dynamic> data = responseMap['data'];

        return data.map((bookMap) => ListBook.fromMap(bookMap)).toList();
      } else {
        throw Exception('Failed to load books: ${responseMap['message']}');
      }
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }
}
