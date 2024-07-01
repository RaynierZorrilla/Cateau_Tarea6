import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in RD'),
      ),
      body: Consumer<WeatherModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (model.isLoading) CircularProgressIndicator(),
                  if (model.errorMessage.isNotEmpty) Text(model.errorMessage, style: TextStyle(color: Colors.red)),
                  if (model.weather.isNotEmpty && !model.isLoading)
                    Column(
                      children: [
                        Text(
                          'Current Weather:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          model.weather,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
