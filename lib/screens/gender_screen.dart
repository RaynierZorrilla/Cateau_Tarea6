import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gender_model.dart';

class GenderScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Gender'),
      ),
      body: Consumer<GenderModel>(
        builder: (context, model, child) {
          return Container(
            color: model.bgColor,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => model.predictGender(_controller.text),
                    child: Text('Predict'),
                  ),
                  if (model.isLoading) CircularProgressIndicator(),
                  if (model.errorMessage.isNotEmpty) Text(model.errorMessage, style: TextStyle(color: Colors.red)),
                  if (model.gender.isNotEmpty && !model.isLoading)
                    Text(
                      'Gender: ${model.gender}',
                      style: TextStyle(fontSize: 20),
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
