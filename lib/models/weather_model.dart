import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherModel extends ChangeNotifier {
  String _weather = '';
  String _errorMessage = '';
  bool _isLoading = false;

  String get weather => _weather;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getWeather() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=18.7357&longitude=-70.1627&hourly=temperature_2m'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _weather = jsonResponse['hourly']['temperature_2m'].toString();
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
