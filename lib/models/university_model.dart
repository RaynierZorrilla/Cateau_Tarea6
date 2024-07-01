import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UniversityModel extends ChangeNotifier {
  List _universities = [];
  String _errorMessage = '';
  bool _isLoading = false;

  List get universities => _universities;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> searchUniversities(String country) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _universities = jsonResponse;
      } else {
        _errorMessage = 'Failed to get response from server';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
