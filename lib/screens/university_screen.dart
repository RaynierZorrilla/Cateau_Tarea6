import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/university_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Universities'),
      ),
      body: Consumer<UniversityModel>(
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
                      labelText: 'Enter Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => model.searchUniversities(_controller.text),
                    child: Text('Search'),
                  ),
                  if (model.isLoading) CircularProgressIndicator(),
                  if (model.errorMessage.isNotEmpty) Text(model.errorMessage, style: TextStyle(color: Colors.red)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.universities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(model.universities[index]['name']),
                          subtitle: Text(model.universities[index]['domain']),
                          onTap: () => _launchURL(model.universities[index]['web_pages'][0]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
