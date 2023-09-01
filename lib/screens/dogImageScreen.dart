import 'package:finn_task/model/dogImageModel.dart';
import 'package:flutter/material.dart';

import '../constants/api_urls.dart';
import '../services/api_services.dart';

class DogImageScreen extends StatefulWidget {
  const DogImageScreen({super.key});

  @override
  _DogImageScreenState createState() => _DogImageScreenState();
}

class _DogImageScreenState extends State<DogImageScreen> {
  String imageUrl = '';

  Future<void> fetchDogImage() async {
    dynamic responseData =
        await ApiService().getApiCall(ApiConstants.dogImageURL);
    if (responseData != "" && responseData != null) {
      print(responseData);
      DogImageModel model = dogImageModelFromJson(responseData.body);
      setState(() {
        imageUrl = model.message ?? "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Image Viewer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl.isNotEmpty) Image.network(imageUrl),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => fetchDogImage(),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
