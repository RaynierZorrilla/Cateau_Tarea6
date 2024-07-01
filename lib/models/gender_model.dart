import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GenderModel extends ChangeNotifier {
  String _gender = '';
  Color _bgColor = Colors.white;
  String _errorMessage = '';
  bool _isLoading = false;

  String get gender => _gender;
  Color get bgColor => _bgColor;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> predictGender(String name) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _gender = jsonResponse['gender'];
        _bgColor = _gender == 'male' ? Colors.blue : Colors.pink;
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
