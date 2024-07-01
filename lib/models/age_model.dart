import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgeModel extends ChangeNotifier {
  int _age = -1;
  String _message = '';
  String _imagePath = '';
  String _errorMessage = '';
  bool _isLoading = false;

  int get age => _age;
  String get message => _message;
  String get imagePath => _imagePath;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> predictAge(String name) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _age = jsonResponse['age'];
        if (_age < 18) {
          _message = 'You are young';
          _imagePath = 'assets/young.jpg';
        } else if (_age < 60) {
          _message = 'You are an adult';
          _imagePath = 'assets/adult.jpg';
        } else {
          _message = 'You are elderly';
          _imagePath = 'assets/elderly.jpg';
        }
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
