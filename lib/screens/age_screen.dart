import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/age_model.dart';

class AgeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Age'),
      ),
      body: Consumer<AgeModel>(
        builder: (context, model, child) {
          return Padding(
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
                    onPressed: () => model.predictAge(_controller.text),
                    child: Text('Predict'),
                  ),
                  if (model.isLoading) CircularProgressIndicator(),
                  if (model.errorMessage.isNotEmpty) Text(model.errorMessage, style: TextStyle(color: Colors.red)),
                  if (model.age != -1 && !model.isLoading)
                    Column(
                      children: [
                        Text(
                          'Age: ${model.age}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          model.message,
                          style: TextStyle(fontSize: 20),
                        ),
                        if (model.imagePath.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: Image.asset(
                              model.imagePath,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
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
